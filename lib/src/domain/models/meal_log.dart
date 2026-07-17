/// meal_log.dart
///
/// Domain entity representing one logged meal (e.g., "Breakfast", "Dinner").
///
/// A [MealLog] groups one or more [LoggedFoodEntry] records that were
/// consumed together. It computes aggregate macronutrient totals on demand
/// using [FoodItem.macrosForAmount] so no denormalised values need to be
/// stored.
library;

import 'package:equatable/equatable.dart';

import 'food_item.dart';

// ── Supporting Types ─────────────────────────────────────────────────────────

/// Categorises a meal by time of day or purpose.
enum MealType {
  breakfast,
  morningSnack,
  lunch,
  afternoonSnack,
  dinner,
  eveningSnack,
  preworkout,
  postworkout,
  other;

  String get displayName => switch (this) {
        MealType.breakfast => 'Breakfast',
        MealType.morningSnack => 'Morning Snack',
        MealType.lunch => 'Lunch',
        MealType.afternoonSnack => 'Afternoon Snack',
        MealType.dinner => 'Dinner',
        MealType.eveningSnack => 'Evening Snack',
        MealType.preworkout => 'Pre-Workout',
        MealType.postworkout => 'Post-Workout',
        MealType.other => 'Other',
      };
}

/// A single food item entry within a [MealLog], with the actual consumed
/// amount expressed in grams.
final class LoggedFoodEntry extends Equatable {
  const LoggedFoodEntry({
    required this.id,
    required this.foodItem,
    required this.consumedGrams,
  }) : assert(consumedGrams > 0, 'Consumed grams must be positive');

  /// Unique identifier for this specific log entry (UUID v4).
  final String id;

  /// The food item reference.
  final FoodItem foodItem;

  /// Actual weight consumed in grams.
  final double consumedGrams;

  /// Pre-computed macros for the consumed portion.
  MacroSnapshot get macros => foodItem.macrosForAmount(consumedGrams);

  LoggedFoodEntry copyWith({
    String? id,
    FoodItem? foodItem,
    double? consumedGrams,
  }) {
    return LoggedFoodEntry(
      id: id ?? this.id,
      foodItem: foodItem ?? this.foodItem,
      consumedGrams: consumedGrams ?? this.consumedGrams,
    );
  }

  @override
  List<Object?> get props => [id, foodItem, consumedGrams];

  @override
  String toString() =>
      'LoggedFoodEntry(${foodItem.name}, ${consumedGrams}g)';
}

// ── MealLog ───────────────────────────────────────────────────────────────────

/// An immutable record of a meal consumed at a specific point in time.
///
/// [totalMacros] is computed lazily as the sum of all [LoggedFoodEntry.macros]
/// and is cached after first access.
final class MealLog extends Equatable {
  MealLog({
    required this.id,
    required this.loggedAt,
    required this.mealType,
    required this.entries,
    this.notes,
  }) : assert(entries.isNotEmpty, 'A MealLog must contain at least one entry');

  // ── Fields ───────────────────────────────────────────────────────────────

  /// Unique identifier (UUID v4).
  final String id;

  /// Wall-clock time this meal was logged.
  final DateTime loggedAt;

  /// The type / category of this meal.
  final MealType mealType;

  /// The food items consumed in this meal.
  final List<LoggedFoodEntry> entries;

  /// Optional free-text notes attached to the meal.
  final String? notes;

  // ── Derived / computed properties ────────────────────────────────────────

  /// Aggregate macros for this entire meal, lazily computed and cached.
  late final MacroSnapshot totalMacros = entries.fold(
    MacroSnapshot.zero,
    (acc, entry) => acc + entry.macros,
  );

  /// Total calories for this meal.
  double get totalCalories => totalMacros.calories;

  /// Total protein for this meal in grams.
  double get totalProteinG => totalMacros.proteinG;

  /// Total carbs for this meal in grams.
  double get totalCarbsG => totalMacros.carbsG;

  /// Total fat for this meal in grams.
  double get totalFatG => totalMacros.fatG;

  /// The calendar date (year / month / day, time zeroed) this log belongs to.
  DateTime get logDate =>
      DateTime(loggedAt.year, loggedAt.month, loggedAt.day);

  /// Number of distinct food items in this meal.
  int get itemCount => entries.length;

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Returns a new [MealLog] with [entry] appended to the existing entries.
  MealLog withEntry(LoggedFoodEntry entry) => copyWith(
        entries: List.unmodifiable([...entries, entry]),
      );

  /// Returns a new [MealLog] with the entry matching [entryId] removed.
  ///
  /// Throws [StateError] if [entryId] is not found.
  MealLog withoutEntry(String entryId) {
    final updated = entries.where((e) => e.id != entryId).toList();
    if (updated.length == entries.length) {
      throw StateError('No entry with id "$entryId" found in MealLog $id');
    }
    return copyWith(entries: List.unmodifiable(updated));
  }

  /// Returns a new [MealLog] with [entry] replacing the existing entry
  /// that shares the same [LoggedFoodEntry.id].
  MealLog withUpdatedEntry(LoggedFoodEntry entry) {
    final updated = entries.map((e) => e.id == entry.id ? entry : e).toList();
    return copyWith(entries: List.unmodifiable(updated));
  }

  // ── copyWith ──────────────────────────────────────────────────────────────

  MealLog copyWith({
    String? id,
    DateTime? loggedAt,
    MealType? mealType,
    List<LoggedFoodEntry>? entries,
    String? notes,
  }) {
    return MealLog(
      id: id ?? this.id,
      loggedAt: loggedAt ?? this.loggedAt,
      mealType: mealType ?? this.mealType,
      entries: entries ?? this.entries,
      notes: notes ?? this.notes,
    );
  }

  // ── Equatable ─────────────────────────────────────────────────────────────

  @override
  List<Object?> get props => [id, loggedAt, mealType, entries, notes];

  @override
  String toString() =>
      'MealLog(id: $id, type: ${mealType.displayName}, '
      'items: $itemCount, cal: $totalCalories)';
}
