// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_food_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarFoodItemCollection on Isar {
  IsarCollection<IsarFoodItem> get isarFoodItems => this.collection();
}

const IsarFoodItemSchema = CollectionSchema(
  name: r'FoodItems',
  id: -8856457209121923257,
  properties: {
    r'barcode': PropertySchema(
      id: 0,
      name: r'barcode',
      type: IsarType.string,
    ),
    r'brand': PropertySchema(
      id: 1,
      name: r'brand',
      type: IsarType.string,
    ),
    r'calories': PropertySchema(
      id: 2,
      name: r'calories',
      type: IsarType.double,
    ),
    r'carbsG': PropertySchema(
      id: 3,
      name: r'carbsG',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 4,
      name: r'category',
      type: IsarType.string,
    ),
    r'cholesterolMg': PropertySchema(
      id: 5,
      name: r'cholesterolMg',
      type: IsarType.double,
    ),
    r'fatG': PropertySchema(
      id: 6,
      name: r'fatG',
      type: IsarType.double,
    ),
    r'fiberG': PropertySchema(
      id: 7,
      name: r'fiberG',
      type: IsarType.double,
    ),
    r'foodId': PropertySchema(
      id: 8,
      name: r'foodId',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 9,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'isCustom': PropertySchema(
      id: 10,
      name: r'isCustom',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'proteinG': PropertySchema(
      id: 12,
      name: r'proteinG',
      type: IsarType.double,
    ),
    r'saturatedFatG': PropertySchema(
      id: 13,
      name: r'saturatedFatG',
      type: IsarType.double,
    ),
    r'servingSizeG': PropertySchema(
      id: 14,
      name: r'servingSizeG',
      type: IsarType.double,
    ),
    r'sodiumMg': PropertySchema(
      id: 15,
      name: r'sodiumMg',
      type: IsarType.double,
    ),
    r'sugarG': PropertySchema(
      id: 16,
      name: r'sugarG',
      type: IsarType.double,
    ),
    r'updatedAt': PropertySchema(
      id: 17,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _isarFoodItemEstimateSize,
  serialize: _isarFoodItemSerialize,
  deserialize: _isarFoodItemDeserialize,
  deserializeProp: _isarFoodItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'foodId': IndexSchema(
      id: 6823679418906861405,
      name: r'foodId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'foodId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'brand': IndexSchema(
      id: 6145529221080171523,
      name: r'brand',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'brand',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarFoodItemGetId,
  getLinks: _isarFoodItemGetLinks,
  attach: _isarFoodItemAttach,
  version: '3.3.0',
);

int _isarFoodItemEstimateSize(
  IsarFoodItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.barcode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.brand;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.foodId.length * 3;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _isarFoodItemSerialize(
  IsarFoodItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcode);
  writer.writeString(offsets[1], object.brand);
  writer.writeDouble(offsets[2], object.calories);
  writer.writeDouble(offsets[3], object.carbsG);
  writer.writeString(offsets[4], object.category);
  writer.writeDouble(offsets[5], object.cholesterolMg);
  writer.writeDouble(offsets[6], object.fatG);
  writer.writeDouble(offsets[7], object.fiberG);
  writer.writeString(offsets[8], object.foodId);
  writer.writeString(offsets[9], object.imageUrl);
  writer.writeBool(offsets[10], object.isCustom);
  writer.writeString(offsets[11], object.name);
  writer.writeDouble(offsets[12], object.proteinG);
  writer.writeDouble(offsets[13], object.saturatedFatG);
  writer.writeDouble(offsets[14], object.servingSizeG);
  writer.writeDouble(offsets[15], object.sodiumMg);
  writer.writeDouble(offsets[16], object.sugarG);
  writer.writeDateTime(offsets[17], object.updatedAt);
}

IsarFoodItem _isarFoodItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarFoodItem();
  object.barcode = reader.readStringOrNull(offsets[0]);
  object.brand = reader.readStringOrNull(offsets[1]);
  object.calories = reader.readDouble(offsets[2]);
  object.carbsG = reader.readDouble(offsets[3]);
  object.category = reader.readStringOrNull(offsets[4]);
  object.cholesterolMg = reader.readDouble(offsets[5]);
  object.fatG = reader.readDouble(offsets[6]);
  object.fiberG = reader.readDouble(offsets[7]);
  object.foodId = reader.readString(offsets[8]);
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[9]);
  object.isCustom = reader.readBool(offsets[10]);
  object.name = reader.readString(offsets[11]);
  object.proteinG = reader.readDouble(offsets[12]);
  object.saturatedFatG = reader.readDouble(offsets[13]);
  object.servingSizeG = reader.readDouble(offsets[14]);
  object.sodiumMg = reader.readDouble(offsets[15]);
  object.sugarG = reader.readDouble(offsets[16]);
  object.updatedAt = reader.readDateTime(offsets[17]);
  return object;
}

P _isarFoodItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readDouble(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarFoodItemGetId(IsarFoodItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarFoodItemGetLinks(IsarFoodItem object) {
  return [];
}

void _isarFoodItemAttach(
    IsarCollection<dynamic> col, Id id, IsarFoodItem object) {
  object.id = id;
}

extension IsarFoodItemByIndex on IsarCollection<IsarFoodItem> {
  Future<IsarFoodItem?> getByFoodId(String foodId) {
    return getByIndex(r'foodId', [foodId]);
  }

  IsarFoodItem? getByFoodIdSync(String foodId) {
    return getByIndexSync(r'foodId', [foodId]);
  }

  Future<bool> deleteByFoodId(String foodId) {
    return deleteByIndex(r'foodId', [foodId]);
  }

  bool deleteByFoodIdSync(String foodId) {
    return deleteByIndexSync(r'foodId', [foodId]);
  }

  Future<List<IsarFoodItem?>> getAllByFoodId(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'foodId', values);
  }

  List<IsarFoodItem?> getAllByFoodIdSync(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'foodId', values);
  }

  Future<int> deleteAllByFoodId(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'foodId', values);
  }

  int deleteAllByFoodIdSync(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'foodId', values);
  }

  Future<Id> putByFoodId(IsarFoodItem object) {
    return putByIndex(r'foodId', object);
  }

  Id putByFoodIdSync(IsarFoodItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'foodId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFoodId(List<IsarFoodItem> objects) {
    return putAllByIndex(r'foodId', objects);
  }

  List<Id> putAllByFoodIdSync(List<IsarFoodItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'foodId', objects, saveLinks: saveLinks);
  }
}

extension IsarFoodItemQueryWhereSort
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QWhere> {
  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarFoodItemQueryWhere
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QWhereClause> {
  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> foodIdEqualTo(
      String foodId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'foodId',
        value: [foodId],
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> foodIdNotEqualTo(
      String foodId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [],
              upper: [foodId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [foodId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [foodId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [],
              upper: [foodId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> brandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'brand',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> brandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'brand',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> brandEqualTo(
      String? brand) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'brand',
        value: [brand],
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterWhereClause> brandNotEqualTo(
      String? brand) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [],
              upper: [brand],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [brand],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [brand],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [],
              upper: [brand],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarFoodItemQueryFilter
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QFilterCondition> {
  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barcode',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barcode',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcode',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      barcodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcode',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      brandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brand',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      brandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brand',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> brandEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      brandGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> brandLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> brandBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      brandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> brandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> brandContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> brandMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      caloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      caloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      caloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      caloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> carbsGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carbsG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      carbsGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carbsG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      carbsGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carbsG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> carbsGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carbsG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      cholesterolMgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cholesterolMg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      cholesterolMgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cholesterolMg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      cholesterolMgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cholesterolMg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      cholesterolMgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cholesterolMg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> fatGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      fatGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> fatGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> fatGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> fiberGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fiberG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      fiberGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fiberG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      fiberGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fiberG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> fiberGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fiberG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> foodIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> foodIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> foodIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      foodIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      isCustomEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCustom',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      proteinGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proteinG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      proteinGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proteinG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      proteinGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proteinG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      proteinGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proteinG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      saturatedFatGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'saturatedFatG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      saturatedFatGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'saturatedFatG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      saturatedFatGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'saturatedFatG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      saturatedFatGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'saturatedFatG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      servingSizeGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servingSizeG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      servingSizeGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servingSizeG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      servingSizeGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servingSizeG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      servingSizeGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servingSizeG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      sodiumMgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sodiumMg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      sodiumMgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sodiumMg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      sodiumMgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sodiumMg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      sodiumMgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sodiumMg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> sugarGEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sugarG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      sugarGGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sugarG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      sugarGLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sugarG',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition> sugarGBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sugarG',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarFoodItemQueryObject
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QFilterCondition> {}

extension IsarFoodItemQueryLinks
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QFilterCondition> {}

extension IsarFoodItemQuerySortBy
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QSortBy> {
  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByBarcode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByBarcodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCarbsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCarbsGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByCholesterolMg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cholesterolMg', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy>
      sortByCholesterolMgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cholesterolMg', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByFatG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByFatGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByFiberG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByFiberGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByProteinG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByProteinGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortBySaturatedFatG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saturatedFatG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy>
      sortBySaturatedFatGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saturatedFatG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByServingSizeG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingSizeG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy>
      sortByServingSizeGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingSizeG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortBySodiumMg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sodiumMg', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortBySodiumMgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sodiumMg', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortBySugarG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortBySugarGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarFoodItemQuerySortThenBy
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QSortThenBy> {
  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByBarcode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByBarcodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcode', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCarbsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCarbsGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbsG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByCholesterolMg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cholesterolMg', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy>
      thenByCholesterolMgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cholesterolMg', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByFatG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByFatGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByFiberG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByFiberGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fiberG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByProteinG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByProteinGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenBySaturatedFatG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saturatedFatG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy>
      thenBySaturatedFatGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saturatedFatG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByServingSizeG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingSizeG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy>
      thenByServingSizeGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servingSizeG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenBySodiumMg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sodiumMg', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenBySodiumMgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sodiumMg', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenBySugarG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarG', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenBySugarGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sugarG', Sort.desc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarFoodItemQueryWhereDistinct
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> {
  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByBarcode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByBrand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByCarbsG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbsG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct>
      distinctByCholesterolMg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cholesterolMg');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByFatG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByFiberG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fiberG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByFoodId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustom');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByProteinG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct>
      distinctBySaturatedFatG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saturatedFatG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByServingSizeG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servingSizeG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctBySodiumMg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sodiumMg');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctBySugarG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sugarG');
    });
  }

  QueryBuilder<IsarFoodItem, IsarFoodItem, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension IsarFoodItemQueryProperty
    on QueryBuilder<IsarFoodItem, IsarFoodItem, QQueryProperty> {
  QueryBuilder<IsarFoodItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarFoodItem, String?, QQueryOperations> barcodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcode');
    });
  }

  QueryBuilder<IsarFoodItem, String?, QQueryOperations> brandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brand');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> carbsGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbsG');
    });
  }

  QueryBuilder<IsarFoodItem, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> cholesterolMgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cholesterolMg');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> fatGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatG');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> fiberGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fiberG');
    });
  }

  QueryBuilder<IsarFoodItem, String, QQueryOperations> foodIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodId');
    });
  }

  QueryBuilder<IsarFoodItem, String?, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<IsarFoodItem, bool, QQueryOperations> isCustomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustom');
    });
  }

  QueryBuilder<IsarFoodItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> proteinGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinG');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> saturatedFatGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saturatedFatG');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> servingSizeGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servingSizeG');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> sodiumMgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sodiumMg');
    });
  }

  QueryBuilder<IsarFoodItem, double, QQueryOperations> sugarGProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sugarG');
    });
  }

  QueryBuilder<IsarFoodItem, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
