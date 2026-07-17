/// tracker_repository_impl.dart
///
/// Concrete implementation of the [TrackerRepository] domain contract.
///
/// ### Architecture
/// This class is the single crossing-point between the Domain and
/// Infrastructure layers. It wires:
///   - [IsarService]   → local-first read / write operations
///   - [DioClient]     → remote USDA FoodData Central API access
///
/// ### Offline-First Strategy
/// 1. Reads always attempt the local Isar store first.
/// 2. When a local result is empty **and** the device is online, the
///    implementation falls back to the network, caches the result, then
///    returns it.
/// 3. Write operations persist to Isar immediately; remote sync (if added
///    later) can be layered on as a background outbox pattern.
///
/// ### Error handling
/// Every public method is wrapped in a try/catch that maps raw exceptions to
/// typed [Failure] subtypes so that no raw exception ever propagates into
/// the Domain or Presentation layers.
library;

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/failures.dart';
import '../../domain/models/food_item.dart';
import '../../domain/models/meal_log.dart';
import '../../domain/repositories/tracker_repository.dart';
import '../api/dio_client.dart';
import '../database/isar_service.dart';
import '../database/models/isar_food_item.dart';
import '../database/models/isar_meal_log.dart';

// ── TrackerRepositoryImpl ─────────────────────────────────────────────────────

/// Injectable concrete adapter for [TrackerRepository].
///
/// Register in the DI container:
/// ```dart
/// getIt.registerLazySingleton<TrackerRepository>(
///   () => TrackerRepositoryImpl(
///     isarService: getIt<IsarService>(),
///     dioClient:   getIt<DioClient>(),
///   ),
/// );
/// ```
final class TrackerRepositoryImpl implements TrackerRepository {
  TrackerRepositoryImpl({
    required IsarService isarService,
    required DioClient dioClient,
  })  : _isar = isarService,
        _dio = dioClient;

  final IsarService _isar;
  final DioClient _dio;

  // UUID generator — used when saving incomplete entities.
  static const _uuid = Uuid();

  // ── Daily Logs ────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<MealLog>>> getDailyLogs(DateTime date) async {
    try {
      final from = DateTime.utc(date.year, date.month, date.day);
      final to = from.add(const Duration(days: 1));

      final models = await _isar.readTxn(
        (db) => db.isarMealLogs
            .where()
            .logDateBetween(from, to, includeLower: true, includeUpper: false)
            .findAll(),
      );

      final logs = models.map((m) => m.toDomain()).toList(growable: false);
      return Right(logs);
    } on Failure catch (f) {
      return Left(f);
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to read daily logs from local database: $e',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MealLog>>> getLogsInRange({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final utcFrom = DateTime.utc(from.year, from.month, from.day);
      final utcTo = DateTime.utc(to.year, to.month, to.day)
          .add(const Duration(days: 1)); // inclusive end

      final models = await _isar.readTxn(
        (db) => db.isarMealLogs
            .where()
            .logDateBetween(utcFrom, utcTo,
                includeLower: true, includeUpper: false)
            .sortByLoggedAt()
            .findAll(),
      );

      final logs = models.map((m) => m.toDomain()).toList(growable: false);
      return Right(logs);
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to read logs in range from local database: $e',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MealLog>> saveMealLog(MealLog log) async {
    try {
      final model = IsarMealLog.fromDomain(log);

      await _isar.writeTxn(
        (db) async => db.isarMealLogs.put(model),
      );

      // Re-query to return the domain entity constructed from freshly
      // persisted data (guarantees consistency with Isar-assigned id etc.)
      final saved = await _isar.readTxn(
        (db) => db.isarMealLogs.getByLogId(log.id),
      );

      if (saved == null) {
        return Left(
          CacheFailure(
            message: 'MealLog was written but could not be re-read from Isar.',
          ),
        );
      }

      return Right(saved.toDomain());
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to save MealLog to local database: $e',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MealLog>> updateMealLog(MealLog log) async {
    try {
      // Verify the log exists before blindly overwriting.
      final existing = await _isar.readTxn(
        (db) => db.isarMealLogs.getByLogId(log.id),
      );

      if (existing == null) {
        return Left(
          CacheNotFoundFailure(
            message: 'Cannot update MealLog "${log.id}": not found.',
          ),
        );
      }

      // Preserve the Isar internal id so the put acts as an update.
      final model = IsarMealLog.fromDomain(log)..id = existing.id;

      await _isar.writeTxn(
        (db) async => db.isarMealLogs.put(model),
      );

      return Right(log);
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to update MealLog in local database: $e',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMealLog(String id) async {
    try {
      final existing = await _isar.readTxn(
        (db) => db.isarMealLogs.getByLogId(id),
      );

      if (existing == null) {
        return Left(
          CacheNotFoundFailure(
            message: 'Cannot delete MealLog "$id": not found.',
          ),
        );
      }

      await _isar.writeTxn(
        (db) async => db.isarMealLogs.delete(existing.id),
      );

      return const Right(unit);
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to delete MealLog from local database: $e',
          stackTrace: st,
        ),
      );
    }
  }

  // ── Food Search ───────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<FoodItem>>> searchFood({
    required String query,
    int pageSize = 25,
    int pageNumber = 1,
  }) async {
    // 1. Check local cache first (exact substring on name index).
    try {
      final cached = await _isar.readTxn(
        (db) => db.isarFoodItems
            .filter()
            .nameContains(query, caseSensitive: false)
            .limit(pageSize)
            .findAll(),
      );

      if (cached.isNotEmpty) {
        final items = cached.map((m) => m.toDomain()).toList(growable: false);
        return Right(items);
      }
    } catch (_) {
      // Cache miss or error — fall through to network.
    }

    // 2. Network fallback (USDA FoodData Central `/foods/search`).
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/foods/search',
        queryParameters: {
          'query': query,
          'pageSize': pageSize,
          'pageNumber': pageNumber,
          'dataType': 'Branded,Foundation,SR Legacy',
        },
      );

      final body = response.data;
      if (body == null) {
        return Left(
          DeserializationFailure(
            message: 'Food search returned a null payload.',
          ),
        );
      }

      final rawFoods = body['foods'] as List<dynamic>? ?? [];
      final isarModels = rawFoods
          .whereType<Map<String, dynamic>>()
          .map(IsarFoodItem.fromFdcJson)
          .toList(growable: false);

      // 3. Cache results locally for offline access.
      await _isar.writeTxn(
        (db) async => db.isarFoodItems.putAll(isarModels),
      );

      final items = isarModels.map((m) => m.toDomain()).toList(growable: false);
      return Right(items);
    } on Failure catch (f) {
      return Left(f);
    } catch (e, st) {
      return Left(
        UnexpectedFailure(
          message: 'Unexpected error during food search: $e',
          stackTrace: st,
          originalException: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FoodItem>> getFoodById(String id) async {
    // 1. Local cache hit.
    try {
      final cached = await _isar.readTxn(
        (db) => db.isarFoodItems.getByFoodId(id),
      );
      if (cached != null) return Right(cached.toDomain());
    } catch (_) {
      // ignore — fall through to network
    }

    // 2. Remote fetch.
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/food/$id');

      final body = response.data;
      if (body == null) {
        return Left(
          DeserializationFailure(
            message: 'getFoodById returned null for id "$id".',
          ),
        );
      }

      final model = IsarFoodItem.fromFdcJson(body);

      await _isar.writeTxn(
        (db) async => db.isarFoodItems.put(model),
      );

      return Right(model.toDomain());
    } on Failure catch (f) {
      return Left(f);
    } catch (e, st) {
      return Left(
        UnexpectedFailure(
          message: 'Unexpected error fetching food by id "$id": $e',
          stackTrace: st,
          originalException: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FoodItem>> getFoodByBarcode(String barcode) async {
    // 1. Local cache.
    try {
      final cached = await _isar.readTxn(
        (db) => db.isarFoodItems
            .filter()
            .barcodeEqualTo(barcode)
            .findFirst(),
      );
      if (cached != null) return Right(cached.toDomain());
    } catch (_) {
      // fall through
    }

    // 2. FDC UPC lookup.
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/foods/search',
        queryParameters: {
          'query': barcode,
          'pageSize': 1,
        },
      );

      final body = response.data;
      final foods = body?['foods'] as List<dynamic>? ?? [];

      if (foods.isEmpty) {
        return Left(
          CacheNotFoundFailure(
            message: 'No food found for barcode "$barcode".',
          ),
        );
      }

      final model =
          IsarFoodItem.fromFdcJson(foods.first as Map<String, dynamic>);
      model.barcode = barcode;

      await _isar.writeTxn(
        (db) async => db.isarFoodItems.put(model),
      );

      return Right(model.toDomain());
    } on Failure catch (f) {
      return Left(f);
    } catch (e, st) {
      return Left(
        UnexpectedFailure(
          message: 'Unexpected error fetching food by barcode "$barcode": $e',
          stackTrace: st,
          originalException: e,
        ),
      );
    }
  }

  // ── Custom Food Items ─────────────────────────────────────────────────────

  @override
  Future<Either<Failure, FoodItem>> saveCustomFood(FoodItem item) async {
    if (!item.isCustom) {
      return Left(
        ValidationFailure(
          message:
              'saveCustomFood requires item.isCustom == true. '
              'Use searchFood for API-sourced items.',
        ),
      );
    }

    try {
      final model = IsarFoodItem.fromDomain(item);

      await _isar.writeTxn(
        (db) async => db.isarFoodItems.put(model),
      );

      return Right(model.toDomain());
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to save custom food: $e',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<FoodItem>>> getCustomFoods() async {
    try {
      final models = await _isar.readTxn(
        (db) => db.isarFoodItems
            .filter()
            .isCustomEqualTo(true)
            .sortByName()
            .findAll(),
      );

      final items = models.map((m) => m.toDomain()).toList(growable: false);
      return Right(items);
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to read custom foods: $e',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomFood(String id) async {
    try {
      final existing = await _isar.readTxn(
        (db) => db.isarFoodItems.getByFoodId(id),
      );

      if (existing == null) {
        return Left(
          CacheNotFoundFailure(
            message: 'Custom food "$id" not found.',
          ),
        );
      }

      if (!existing.isCustom) {
        return Left(
          ValidationFailure(
            message:
                'Cannot delete food "$id" via deleteCustomFood '
                'because it is not a custom food.',
          ),
        );
      }

      await _isar.writeTxn(
        (db) async => db.isarFoodItems.delete(existing.id),
      );

      return const Right(unit);
    } catch (e, st) {
      return Left(
        CacheFailure(
          message: 'Failed to delete custom food: $e',
          stackTrace: st,
        ),
      );
    }
  }

  // ── Reactive Stream ────────────────────────────────────────────────────────

  @override
  Stream<Either<Failure, List<MealLog>>> watchDailyLogs(DateTime date) {
    final utcFrom = DateTime.utc(date.year, date.month, date.day);
    final utcTo = utcFrom.add(const Duration(days: 1));

    final query = _isar.db.isarMealLogs
        .where()
        .logDateBetween(utcFrom, utcTo,
            includeLower: true, includeUpper: false)
        .build();

    return query
        .watch(fireImmediately: true)
        .map<Either<Failure, List<MealLog>>>(
          (models) {
            try {
              final logs =
                  models.map((m) => m.toDomain()).toList(growable: false);
              return Right(logs);
            } catch (e, st) {
              return Left(
                CacheFailure(
                  message: 'Error mapping watched meal logs: $e',
                  stackTrace: st,
                ),
              );
            }
          },
        )
        .handleError(
          (Object e, StackTrace st) => Left<Failure, List<MealLog>>(
            CacheFailure(
              message: 'Isar watch stream error: $e',
              stackTrace: st,
            ),
          ),
        );
  }
}
