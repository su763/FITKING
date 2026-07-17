import 'package:isar_community/isar.dart';

import '../../../domain/models/food_item.dart';
import '../../../domain/models/meal_log.dart';
import 'isar_food_item.dart';

part 'isar_meal_log.g.dart';

// ── Embedded: logged entry (food + consumed grams) ───────────────────────────

/// Embedded document storing one [LoggedFoodEntry] inside an [IsarMealLog].
///
/// All nutritional fields are duplicated from the source [FoodItem] to make
/// macro aggregation possible without secondary lookups.
@embedded
class IsarLoggedEntry {
  IsarLoggedEntry();

  /// UUID matching [LoggedFoodEntry.id].
  late String entryId;

  // ── References back to the source food ──────────────────────────────────
  late String foodId;
  late String foodName;
  String? foodBrand;
  String? foodImageUrl;

  // ── Consumed amount ──────────────────────────────────────────────────────
  late double consumedGrams;

  // ── Snapshot macros (per servingSizeG at time of logging) ────────────────
  late double servingSizeG;
  late double caloriesPerServing;
  late double proteinGPerServing;
  late double carbsGPerServing;
  late double fatGPerServing;
  late double fiberGPerServing;
  late double sugarGPerServing;
  late double sodiumMgPerServing;

  // ── Mappers ──────────────────────────────────────────────────────────────

  /// Converts to the Domain entity [LoggedFoodEntry].
  ///
  /// Reconstructs a lightweight [FoodItem] stub from the embedded snapshot.
  LoggedFoodEntry toDomain() {
    final foodStub = FoodItem(
      id: foodId,
      name: foodName,
      brand: foodBrand,
      calories: caloriesPerServing,
      proteinG: proteinGPerServing,
      carbsG: carbsGPerServing,
      fatG: fatGPerServing,
      servingSizeG: servingSizeG,
      fiberG: fiberGPerServing,
      sugarG: sugarGPerServing,
      sodiumMg: sodiumMgPerServing,
      imageUrl: foodImageUrl,
    );

    return LoggedFoodEntry(
      id: entryId,
      foodItem: foodStub,
      consumedGrams: consumedGrams,
    );
  }

  /// Creates an [IsarLoggedEntry] from a [LoggedFoodEntry] domain object.
  static IsarLoggedEntry fromDomain(LoggedFoodEntry entry) {
    final f = entry.foodItem;
    return IsarLoggedEntry()
      ..entryId = entry.id
      ..foodId = f.id
      ..foodName = f.name
      ..foodBrand = f.brand
      ..foodImageUrl = f.imageUrl
      ..consumedGrams = entry.consumedGrams
      ..servingSizeG = f.servingSizeG
      ..caloriesPerServing = f.calories
      ..proteinGPerServing = f.proteinG
      ..carbsGPerServing = f.carbsG
      ..fatGPerServing = f.fatG
      ..fiberGPerServing = f.fiberG
      ..sugarGPerServing = f.sugarG
      ..sodiumMgPerServing = f.sodiumMg;
  }
}

// ── Collection: meal log ──────────────────────────────────────────────────────

/// Isar collection that mirrors the [MealLog] domain entity.
@collection
@Name('MealLogs')
class IsarMealLog {
  IsarMealLog();

  // ── Isar key ──────────────────────────────────────────────────────────────
  Id id = Isar.autoIncrement;

  // ── Business key ─────────────────────────────────────────────────────────
  @Index(unique: true, replace: true, caseSensitive: true)
  late String logId;

  // ── Meal metadata ─────────────────────────────────────────────────────────
  @Index()
  late DateTime loggedAt;

  /// Serialised [MealType.name] string — Isar does not natively store enums.
  late String mealTypeName;

  String? notes;

  // ── Embedded food entries ─────────────────────────────────────────────────
  List<IsarLoggedEntry> entries = [];

  // ── Derived index fields (denormalised for fast date-range queries) ───────

  /// Date-only portion stored as UTC midnight for efficient index filtering.
  @Index()
  late DateTime logDate;

  // ── Domain Mappers ────────────────────────────────────────────────────────

  /// Converts this Isar model to the [MealLog] domain entity.
  MealLog toDomain() {
    final domainEntries = entries.map((e) => e.toDomain()).toList();

    return MealLog(
      id: logId,
      loggedAt: loggedAt,
      mealType: MealType.values.firstWhere(
        (t) => t.name == mealTypeName,
        orElse: () => MealType.other,
      ),
      entries: List.unmodifiable(domainEntries),
      notes: notes,
    );
  }

  /// Creates an [IsarMealLog] from a [MealLog] domain entity.
  static IsarMealLog fromDomain(MealLog entity) {
    final normalized = DateTime.utc(
      entity.loggedAt.year,
      entity.loggedAt.month,
      entity.loggedAt.day,
    );

    return IsarMealLog()
      ..logId = entity.id
      ..loggedAt = entity.loggedAt.toUtc()
      ..mealTypeName = entity.mealType.name
      ..notes = entity.notes
      ..entries = entity.entries
          .map(IsarLoggedEntry.fromDomain)
          .toList(growable: false)
      ..logDate = normalized;
  }

  @override
  String toString() =>
      'IsarMealLog(logId: $logId, type: $mealTypeName, '
      'entries: ${entries.length}, at: $loggedAt)';
}