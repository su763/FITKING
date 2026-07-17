/// tracker_repository.dart
///
/// Abstract contract (port) for the calorie tracker's data operations.
///
/// Follows the Dependency Inversion principle: the Domain layer defines this
/// interface, and the Infrastructure layer provides the concrete adapter.
///
/// All methods return `Either<Failure, T>`:
///   - `Left<Failure>` — a typed domain failure (see `errors/failures.dart`)
///   - `Right<T>`      — the successfully retrieved / persisted value
library;

import 'package:dartz/dartz.dart';

import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../../core/errors/failures.dart';

/// The complete data contract for the FitKing tracking domain.
///
/// Implementors must be registered with the DI container so that use cases
/// receive the concrete adapter without knowing its implementation details.
abstract interface class TrackerRepository {
  // ── Daily Logs ─────────────────────────────────────────────────────────

  /// Returns all [MealLog] records for the given calendar [date].
  ///
  /// The [date] parameter is normalised to midnight (time component ignored).
  /// An empty list is returned as a successful [Right] when no logs exist.
  Future<Either<Failure, List<MealLog>>> getDailyLogs(DateTime date);

  /// Returns all [MealLog] records between [from] and [to] (both inclusive).
  ///
  /// Used for weekly / monthly summary views.
  Future<Either<Failure, List<MealLog>>> getLogsInRange({
    required DateTime from,
    required DateTime to,
  });

  /// Persists a new [MealLog] to local storage.
  ///
  /// Returns the saved [MealLog] (may differ from [log] if the repository
  /// auto-assigns fields such as server timestamps).
  Future<Either<Failure, MealLog>> saveMealLog(MealLog log);

  /// Replaces an existing [MealLog] identified by [MealLog.id].
  ///
  /// Returns [CacheNotFoundFailure] if the log does not exist.
  Future<Either<Failure, MealLog>> updateMealLog(MealLog log);

  /// Permanently removes the [MealLog] with the given [id].
  ///
  /// Returns [CacheNotFoundFailure] if the log does not exist.
  Future<Either<Failure, Unit>> deleteMealLog(String id);

  // ── Food Search ────────────────────────────────────────────────────────

  /// Searches for food items by [query] string against the remote food API.
  ///
  /// [pageSize] limits the number of results (default 25, max 100).
  /// [pageNumber] enables pagination (1-indexed).
  ///
  /// Returns [NoInternetFailure] when offline, [ServerFailure] on API error.
  Future<Either<Failure, List<FoodItem>>> searchFood({
    required String query,
    int pageSize = 25,
    int pageNumber = 1,
  });

  /// Looks up a [FoodItem] by its unique [id].
  ///
  /// Checks local cache first before hitting the network.
  /// Returns [CacheNotFoundFailure] / [ServerFailure] accordingly.
  Future<Either<Failure, FoodItem>> getFoodById(String id);

  /// Looks up a [FoodItem] by [barcode] (EAN-13 / UPC-A).
  ///
  /// Returns [CacheNotFoundFailure] when the barcode is unknown.
  Future<Either<Failure, FoodItem>> getFoodByBarcode(String barcode);

  // ── Custom Food Items ──────────────────────────────────────────────────

  /// Persists a user-created [FoodItem] to local storage.
  ///
  /// [item.isCustom] must be `true`; returns [ValidationFailure] otherwise.
  Future<Either<Failure, FoodItem>> saveCustomFood(FoodItem item);

  /// Returns all user-created custom [FoodItem]s.
  Future<Either<Failure, List<FoodItem>>> getCustomFoods();

  /// Deletes the custom [FoodItem] with the given [id].
  ///
  /// Returns [ValidationFailure] if the item is not a custom food.
  Future<Either<Failure, Unit>> deleteCustomFood(String id);

  // ── Reactive Stream ────────────────────────────────────────────────────

  /// Emits the updated list of [MealLog]s whenever data for [date] changes.
  ///
  /// Use this in the presentation layer instead of polling [getDailyLogs].
  /// The stream closes when the subscriber cancels.
  Stream<Either<Failure, List<MealLog>>> watchDailyLogs(DateTime date);
}
