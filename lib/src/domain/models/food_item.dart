/// food_item.dart
///
/// Pure domain entity representing a single food item.
///
/// This class has **no** Flutter, Hive, or JSON dependencies — it lives
/// exclusively in the Domain layer and is framework-agnostic.
library;

import 'package:equatable/equatable.dart';

/// Represents a single food product with its nutritional profile.
///
/// All macro values ([calories], [proteinG], [carbsG], [fatG]) are expressed
/// per [servingSizeG] grams of food. Use [macrosForAmount] to scale values to
/// an arbitrary portion weight.
final class FoodItem extends Equatable {
  const FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.servingSizeG,
    this.brand,
    this.category,
    this.fiberG = 0.0,
    this.sugarG = 0.0,
    this.sodiumMg = 0.0,
    this.saturatedFatG = 0.0,
    this.cholesterolMg = 0.0,
    this.isCustom = false,
    this.imageUrl,
    this.barcode,
  })  : assert(calories >= 0, 'Calories must be non-negative'),
        assert(proteinG >= 0, 'Protein must be non-negative'),
        assert(carbsG >= 0, 'Carbs must be non-negative'),
        assert(fatG >= 0, 'Fat must be non-negative'),
        assert(servingSizeG > 0, 'Serving size must be positive');

  // ── Core identifiers ────────────────────────────────────────────────────

  /// Unique identifier (UUID v4 for custom items, FDC id for API items).
  final String id;

  /// Display name of the food (e.g., "Chicken Breast, cooked").
  final String name;

  /// Optional brand name (e.g., "Kirkland Signature").
  final String? brand;

  /// Food category (e.g., "Poultry", "Dairy", "Snacks").
  final String? category;

  // ── Primary macronutrients (per serving) ────────────────────────────────

  /// Energy content in kilocalories per [servingSizeG] grams.
  final double calories;

  /// Protein content in grams per [servingSizeG] grams.
  final double proteinG;

  /// Total carbohydrate content in grams per [servingSizeG] grams.
  final double carbsG;

  /// Total fat content in grams per [servingSizeG] grams.
  final double fatG;

  /// Reference serving size in grams these macros are measured against.
  final double servingSizeG;

  // ── Secondary micronutrients (per serving) ───────────────────────────────

  /// Dietary fibre in grams per [servingSizeG] grams.
  final double fiberG;

  /// Total sugar in grams per [servingSizeG] grams.
  final double sugarG;

  /// Sodium in milligrams per [servingSizeG] grams.
  final double sodiumMg;

  /// Saturated fat in grams per [servingSizeG] grams.
  final double saturatedFatG;

  /// Cholesterol in milligrams per [servingSizeG] grams.
  final double cholesterolMg;

  // ── Metadata ─────────────────────────────────────────────────────────────

  /// Whether this item was created by the user (not from the API).
  final bool isCustom;

  /// Optional remote image URL for this food item.
  final String? imageUrl;

  /// Optional EAN / UPC barcode string for barcode-scan lookup.
  final String? barcode;

  // ── Derived helpers ──────────────────────────────────────────────────────

  /// Returns a scaled [_MacroSnapshot] for an arbitrary [amountG] in grams.
  ///
  /// Example — macros for 150 g of chicken:
  /// ```dart
  /// final snap = chicken.macrosForAmount(150);
  /// ```
  MacroSnapshot macrosForAmount(double amountG) {
    assert(amountG > 0, 'Amount must be positive');
    final ratio = amountG / servingSizeG;
    return MacroSnapshot(
      calories: calories * ratio,
      proteinG: proteinG * ratio,
      carbsG: carbsG * ratio,
      fatG: fatG * ratio,
      fiberG: fiberG * ratio,
      sugarG: sugarG * ratio,
      sodiumMg: sodiumMg * ratio,
    );
  }

  /// Calories per gram of food (energy density).
  double get caloriesPerGram => calories / servingSizeG;

  /// Protein percentage of total macro-derived calories.
  ///
  /// Returns 0 when total caloric contribution is zero.
  double get proteinPercent {
    final total = _macroCalories;
    return total == 0 ? 0 : (proteinG * 4 / total) * 100;
  }

  /// Carb percentage of total macro-derived calories.
  double get carbsPercent {
    final total = _macroCalories;
    return total == 0 ? 0 : (carbsG * 4 / total) * 100;
  }

  /// Fat percentage of total macro-derived calories.
  double get fatPercent {
    final total = _macroCalories;
    return total == 0 ? 0 : (fatG * 9 / total) * 100;
  }

  double get _macroCalories => (proteinG * 4) + (carbsG * 4) + (fatG * 9);

  // ── copyWith ─────────────────────────────────────────────────────────────

  FoodItem copyWith({
    String? id,
    String? name,
    String? brand,
    String? category,
    double? calories,
    double? proteinG,
    double? carbsG,
    double? fatG,
    double? servingSizeG,
    double? fiberG,
    double? sugarG,
    double? sodiumMg,
    double? saturatedFatG,
    double? cholesterolMg,
    bool? isCustom,
    String? imageUrl,
    String? barcode,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      servingSizeG: servingSizeG ?? this.servingSizeG,
      fiberG: fiberG ?? this.fiberG,
      sugarG: sugarG ?? this.sugarG,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      saturatedFatG: saturatedFatG ?? this.saturatedFatG,
      cholesterolMg: cholesterolMg ?? this.cholesterolMg,
      isCustom: isCustom ?? this.isCustom,
      imageUrl: imageUrl ?? this.imageUrl,
      barcode: barcode ?? this.barcode,
    );
  }

  // ── Equatable ─────────────────────────────────────────────────────────────

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        category,
        calories,
        proteinG,
        carbsG,
        fatG,
        servingSizeG,
        fiberG,
        sugarG,
        sodiumMg,
        saturatedFatG,
        cholesterolMg,
        isCustom,
        imageUrl,
        barcode,
      ];

  @override
  String toString() =>
      'FoodItem(id: $id, name: $name, cal: $calories, '
      'p: ${proteinG}g, c: ${carbsG}g, f: ${fatG}g / ${servingSizeG}g serving)';
}

// ── MacroSnapshot ─────────────────────────────────────────────────────────────

/// An immutable, scaled snapshot of macronutrients for a specific portion.
///
/// Returned by [FoodItem.macrosForAmount] and aggregated within [MealLog].
final class MacroSnapshot extends Equatable {
  const MacroSnapshot({
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    this.fiberG = 0.0,
    this.sugarG = 0.0,
    this.sodiumMg = 0.0,
  });

  /// Zero-value snapshot useful as a fold accumulator.
  static const zero = MacroSnapshot(
    calories: 0,
    proteinG: 0,
    carbsG: 0,
    fatG: 0,
  );

  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double fiberG;
  final double sugarG;
  final double sodiumMg;

  /// Adds two snapshots together (useful for aggregation).
  MacroSnapshot operator +(MacroSnapshot other) => MacroSnapshot(
        calories: calories + other.calories,
        proteinG: proteinG + other.proteinG,
        carbsG: carbsG + other.carbsG,
        fatG: fatG + other.fatG,
        fiberG: fiberG + other.fiberG,
        sugarG: sugarG + other.sugarG,
        sodiumMg: sodiumMg + other.sodiumMg,
      );

  @override
  List<Object?> get props =>
      [calories, proteinG, carbsG, fatG, fiberG, sugarG, sodiumMg];

  @override
  String toString() =>
      'MacroSnapshot(cal: $calories, p: ${proteinG}g, c: ${carbsG}g, f: ${fatG}g)';
}
