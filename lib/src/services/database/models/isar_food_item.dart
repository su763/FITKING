import 'package:isar_community/isar.dart';

import '../../../domain/models/food_item.dart';

// ── Code-gen directive ───────────────────────────────────────────────────────
part 'isar_food_item.g.dart';

// ── Schema ───────────────────────────────────────────────────────────────────

/// Isar collection that mirrors the [FoodItem] domain entity.
///
/// Uses [id] as the Isar auto-incremented internal key.
/// The stable, business-level UUID is stored in [foodId].
@collection
@Name('FoodItems')
class IsarFoodItem {
  IsarFoodItem();

  // ── Isar primary key (auto) ────────────────────────────────────────────
  Id id = Isar.autoIncrement;

  // ── Business key ──────────────────────────────────────────────────────
  @Index(unique: true, replace: true, caseSensitive: true)
  late String foodId;

  // ── Core identifiers ──────────────────────────────────────────────────
  late String name;

  @Index(caseSensitive: false)
  String? brand;

  String? category;
  String? imageUrl;
  String? barcode;

  // ── Primary macros (per servingSizeGrams) ─────────────────────────────
  late double calories;
  late double proteinG;
  late double carbsG;
  late double fatG;
  late double servingSizeG;

  // ── Secondary micronutrients ──────────────────────────────────────────
  double fiberG = 0.0;
  double sugarG = 0.0;
  double sodiumMg = 0.0;
  double saturatedFatG = 0.0;
  double cholesterolMg = 0.0;

  // ── Metadata ──────────────────────────────────────────────────────────
  bool isCustom = false;

  /// UTC timestamp of the last time this record was updated locally.
  late DateTime updatedAt;

  // ── Domain Mappers ─────────────────────────────────────────────────────

  /// Converts this Isar model into the framework-agnostic [FoodItem] entity.
  FoodItem toDomain() {
    return FoodItem(
      id: foodId,
      name: name,
      brand: brand,
      category: category,
      calories: calories,
      proteinG: proteinG,
      carbsG: carbsG,
      fatG: fatG,
      servingSizeG: servingSizeG,
      fiberG: fiberG,
      sugarG: sugarG,
      sodiumMg: sodiumMg,
      saturatedFatG: saturatedFatG,
      cholesterolMg: cholesterolMg,
      isCustom: isCustom,
      imageUrl: imageUrl,
      barcode: barcode,
    );
  }

  /// Populates an [IsarFoodItem] from a [FoodItem] domain entity.
  ///
  /// Does **not** set the Isar [id] — that remains auto-incremented.
  static IsarFoodItem fromDomain(FoodItem entity) {
    return IsarFoodItem()
      ..foodId = entity.id
      ..name = entity.name
      ..brand = entity.brand
      ..category = entity.category
      ..calories = entity.calories
      ..proteinG = entity.proteinG
      ..carbsG = entity.carbsG
      ..fatG = entity.fatG
      ..servingSizeG = entity.servingSizeG
      ..fiberG = entity.fiberG
      ..sugarG = entity.sugarG
      ..sodiumMg = entity.sodiumMg
      ..saturatedFatG = entity.saturatedFatG
      ..cholesterolMg = entity.cholesterolMg
      ..isCustom = entity.isCustom
      ..imageUrl = entity.imageUrl
      ..barcode = entity.barcode
      ..updatedAt = DateTime.now().toUtc();
  }

  /// Constructs an [IsarFoodItem] from a USDA FoodData Central API JSON
  /// payload (`/foods/search` results array element).
  ///
  /// Gracefully defaults missing fields to zero rather than throwing.
  static IsarFoodItem fromFdcJson(Map<String, dynamic> json) {
    // The FDC API returns nutrients in a flat array keyed by nutrientId.
    double _nutrient(int fdcNutrientId) {
      final nutrients =
          (json['foodNutrients'] as List<dynamic>? ?? []);
      for (final n in nutrients) {
        final map = n as Map<String, dynamic>;
        // Support both search-result shape and detail-endpoint shape.
        final nId = map['nutrientId'] as int? ??
            (map['nutrient'] as Map<String, dynamic>?)?['id'] as int?;
        if (nId == fdcNutrientId) {
          return (map['value'] as num? ??
                  map['amount'] as num? ??
                  0)
              .toDouble();
        }
      }
      return 0.0;
    }

    return IsarFoodItem()
      ..foodId = (json['fdcId'] as int).toString()
      ..name = (json['description'] as String? ?? 'Unknown Food').trim()
      ..brand = json['brandOwner'] as String? ??
          json['brandName'] as String?
      ..category = json['foodCategory'] as String? ??
          json['foodCategoryLabel'] as String?
      ..calories = _nutrient(1008) // Energy (kcal)
      ..proteinG = _nutrient(1003) // Protein
      ..carbsG = _nutrient(1005) // Carbohydrate by difference
      ..fatG = _nutrient(1004) // Total lipid (fat)
      ..servingSizeG = (json['servingSize'] as num? ?? 100).toDouble()
      ..fiberG = _nutrient(1079) // Fiber, total dietary
      ..sugarG = _nutrient(2000) // Sugars, total
      ..sodiumMg = _nutrient(1093) // Sodium
      ..saturatedFatG = _nutrient(1258) // Fatty acids, total saturated
      ..cholesterolMg = _nutrient(1253) // Cholesterol
      ..isCustom = false
      ..imageUrl = null
      ..barcode = json['gtinUpc'] as String?
      ..updatedAt = DateTime.now().toUtc();
  }

  @override
  String toString() =>
      'IsarFoodItem(foodId: $foodId, name: $name, cal: $calories)';
}