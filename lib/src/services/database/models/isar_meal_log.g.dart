// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_meal_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMealLogCollection on Isar {
  IsarCollection<IsarMealLog> get isarMealLogs => this.collection();
}

const IsarMealLogSchema = CollectionSchema(
  name: r'MealLogs',
  id: 5966853398411352583,
  properties: {
    r'entries': PropertySchema(
      id: 0,
      name: r'entries',
      type: IsarType.objectList,
      target: r'IsarLoggedEntry',
    ),
    r'logDate': PropertySchema(
      id: 1,
      name: r'logDate',
      type: IsarType.dateTime,
    ),
    r'logId': PropertySchema(
      id: 2,
      name: r'logId',
      type: IsarType.string,
    ),
    r'loggedAt': PropertySchema(
      id: 3,
      name: r'loggedAt',
      type: IsarType.dateTime,
    ),
    r'mealTypeName': PropertySchema(
      id: 4,
      name: r'mealTypeName',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 5,
      name: r'notes',
      type: IsarType.string,
    )
  },
  estimateSize: _isarMealLogEstimateSize,
  serialize: _isarMealLogSerialize,
  deserialize: _isarMealLogDeserialize,
  deserializeProp: _isarMealLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'logId': IndexSchema(
      id: 3089637606214822530,
      name: r'logId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'logId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'loggedAt': IndexSchema(
      id: 1838198766103160564,
      name: r'loggedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'loggedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'logDate': IndexSchema(
      id: 8404824101822155242,
      name: r'logDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'logDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'IsarLoggedEntry': IsarLoggedEntrySchema},
  getId: _isarMealLogGetId,
  getLinks: _isarMealLogGetLinks,
  attach: _isarMealLogAttach,
  version: '3.3.0',
);

int _isarMealLogEstimateSize(
  IsarMealLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entries.length * 3;
  {
    final offsets = allOffsets[IsarLoggedEntry]!;
    for (var i = 0; i < object.entries.length; i++) {
      final value = object.entries[i];
      bytesCount +=
          IsarLoggedEntrySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.logId.length * 3;
  bytesCount += 3 + object.mealTypeName.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarMealLogSerialize(
  IsarMealLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<IsarLoggedEntry>(
    offsets[0],
    allOffsets,
    IsarLoggedEntrySchema.serialize,
    object.entries,
  );
  writer.writeDateTime(offsets[1], object.logDate);
  writer.writeString(offsets[2], object.logId);
  writer.writeDateTime(offsets[3], object.loggedAt);
  writer.writeString(offsets[4], object.mealTypeName);
  writer.writeString(offsets[5], object.notes);
}

IsarMealLog _isarMealLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMealLog();
  object.entries = reader.readObjectList<IsarLoggedEntry>(
        offsets[0],
        IsarLoggedEntrySchema.deserialize,
        allOffsets,
        IsarLoggedEntry(),
      ) ??
      [];
  object.id = id;
  object.logDate = reader.readDateTime(offsets[1]);
  object.logId = reader.readString(offsets[2]);
  object.loggedAt = reader.readDateTime(offsets[3]);
  object.mealTypeName = reader.readString(offsets[4]);
  object.notes = reader.readStringOrNull(offsets[5]);
  return object;
}

P _isarMealLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<IsarLoggedEntry>(
            offset,
            IsarLoggedEntrySchema.deserialize,
            allOffsets,
            IsarLoggedEntry(),
          ) ??
          []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarMealLogGetId(IsarMealLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarMealLogGetLinks(IsarMealLog object) {
  return [];
}

void _isarMealLogAttach(
    IsarCollection<dynamic> col, Id id, IsarMealLog object) {
  object.id = id;
}

extension IsarMealLogByIndex on IsarCollection<IsarMealLog> {
  Future<IsarMealLog?> getByLogId(String logId) {
    return getByIndex(r'logId', [logId]);
  }

  IsarMealLog? getByLogIdSync(String logId) {
    return getByIndexSync(r'logId', [logId]);
  }

  Future<bool> deleteByLogId(String logId) {
    return deleteByIndex(r'logId', [logId]);
  }

  bool deleteByLogIdSync(String logId) {
    return deleteByIndexSync(r'logId', [logId]);
  }

  Future<List<IsarMealLog?>> getAllByLogId(List<String> logIdValues) {
    final values = logIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'logId', values);
  }

  List<IsarMealLog?> getAllByLogIdSync(List<String> logIdValues) {
    final values = logIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'logId', values);
  }

  Future<int> deleteAllByLogId(List<String> logIdValues) {
    final values = logIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'logId', values);
  }

  int deleteAllByLogIdSync(List<String> logIdValues) {
    final values = logIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'logId', values);
  }

  Future<Id> putByLogId(IsarMealLog object) {
    return putByIndex(r'logId', object);
  }

  Id putByLogIdSync(IsarMealLog object, {bool saveLinks = true}) {
    return putByIndexSync(r'logId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLogId(List<IsarMealLog> objects) {
    return putAllByIndex(r'logId', objects);
  }

  List<Id> putAllByLogIdSync(List<IsarMealLog> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'logId', objects, saveLinks: saveLinks);
  }
}

extension IsarMealLogQueryWhereSort
    on QueryBuilder<IsarMealLog, IsarMealLog, QWhere> {
  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhere> anyLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'loggedAt'),
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhere> anyLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'logDate'),
      );
    });
  }
}

extension IsarMealLogQueryWhere
    on QueryBuilder<IsarMealLog, IsarMealLog, QWhereClause> {
  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logIdEqualTo(
      String logId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'logId',
        value: [logId],
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logIdNotEqualTo(
      String logId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logId',
              lower: [],
              upper: [logId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logId',
              lower: [logId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logId',
              lower: [logId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logId',
              lower: [],
              upper: [logId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> loggedAtEqualTo(
      DateTime loggedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'loggedAt',
        value: [loggedAt],
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> loggedAtNotEqualTo(
      DateTime loggedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loggedAt',
              lower: [],
              upper: [loggedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loggedAt',
              lower: [loggedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loggedAt',
              lower: [loggedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loggedAt',
              lower: [],
              upper: [loggedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> loggedAtGreaterThan(
    DateTime loggedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loggedAt',
        lower: [loggedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> loggedAtLessThan(
    DateTime loggedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loggedAt',
        lower: [],
        upper: [loggedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> loggedAtBetween(
    DateTime lowerLoggedAt,
    DateTime upperLoggedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loggedAt',
        lower: [lowerLoggedAt],
        includeLower: includeLower,
        upper: [upperLoggedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logDateEqualTo(
      DateTime logDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'logDate',
        value: [logDate],
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logDateNotEqualTo(
      DateTime logDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [],
              upper: [logDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [logDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [logDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'logDate',
              lower: [],
              upper: [logDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logDateGreaterThan(
    DateTime logDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'logDate',
        lower: [logDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logDateLessThan(
    DateTime logDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'logDate',
        lower: [],
        upper: [logDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterWhereClause> logDateBetween(
    DateTime lowerLogDate,
    DateTime upperLogDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'logDate',
        lower: [lowerLogDate],
        includeLower: includeLower,
        upper: [upperLogDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarMealLogQueryFilter
    on QueryBuilder<IsarMealLog, IsarMealLog, QFilterCondition> {
  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      entriesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      entriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      entriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      entriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      entriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      entriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'entries',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      logDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      logIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> logIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      logIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> loggedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      loggedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      loggedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> loggedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loggedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mealTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mealTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mealTypeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mealTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mealTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mealTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mealTypeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      mealTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mealTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }
}

extension IsarMealLogQueryObject
    on QueryBuilder<IsarMealLog, IsarMealLog, QFilterCondition> {
  QueryBuilder<IsarMealLog, IsarMealLog, QAfterFilterCondition> entriesElement(
      FilterQuery<IsarLoggedEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'entries');
    });
  }
}

extension IsarMealLogQueryLinks
    on QueryBuilder<IsarMealLog, IsarMealLog, QFilterCondition> {}

extension IsarMealLogQuerySortBy
    on QueryBuilder<IsarMealLog, IsarMealLog, QSortBy> {
  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByLogDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logId', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByLogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logId', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByLoggedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByMealTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealTypeName', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy>
      sortByMealTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealTypeName', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }
}

extension IsarMealLogQuerySortThenBy
    on QueryBuilder<IsarMealLog, IsarMealLog, QSortThenBy> {
  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByLogDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logDate', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByLogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logId', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByLogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logId', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByLoggedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loggedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByMealTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealTypeName', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy>
      thenByMealTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealTypeName', Sort.desc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }
}

extension IsarMealLogQueryWhereDistinct
    on QueryBuilder<IsarMealLog, IsarMealLog, QDistinct> {
  QueryBuilder<IsarMealLog, IsarMealLog, QDistinct> distinctByLogDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logDate');
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QDistinct> distinctByLogId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QDistinct> distinctByLoggedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loggedAt');
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QDistinct> distinctByMealTypeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealTypeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMealLog, IsarMealLog, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }
}

extension IsarMealLogQueryProperty
    on QueryBuilder<IsarMealLog, IsarMealLog, QQueryProperty> {
  QueryBuilder<IsarMealLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMealLog, List<IsarLoggedEntry>, QQueryOperations>
      entriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entries');
    });
  }

  QueryBuilder<IsarMealLog, DateTime, QQueryOperations> logDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logDate');
    });
  }

  QueryBuilder<IsarMealLog, String, QQueryOperations> logIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logId');
    });
  }

  QueryBuilder<IsarMealLog, DateTime, QQueryOperations> loggedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedAt');
    });
  }

  QueryBuilder<IsarMealLog, String, QQueryOperations> mealTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealTypeName');
    });
  }

  QueryBuilder<IsarMealLog, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarLoggedEntrySchema = Schema(
  name: r'IsarLoggedEntry',
  id: 2309142914444168365,
  properties: {
    r'caloriesPerServing': PropertySchema(
      id: 0,
      name: r'caloriesPerServing',
      type: IsarType.double,
    ),
    r'carbsGPerServing': PropertySchema(
      id: 1,
      name: r'carbsGPerServing',
      type: IsarType.double,
    ),
    r'consumedGrams': PropertySchema(
      id: 2,
      name: r'consumedGrams',
      type: IsarType.double,
    ),
    r'entryId': PropertySchema(
      id: 3,
      name: r'entryId',
      type: IsarType.string,
    ),
    r'fatGPerServing': PropertySchema(
      id: 4,
      name: r'fatGPerServing',
      type: IsarType.double,
    ),
    r'fiberGPerServing': PropertySchema(
      id: 5,
      name: r'fiberGPerServing',
      type: IsarType.double,
    ),
    r'foodBrand': PropertySchema(
      id: 6,
      name: r'foodBrand',
      type: IsarType.string,
    ),
    r'foodId': PropertySchema(
      id: 7,
      name: r'foodId',
      type: IsarType.string,
    ),
    r'foodImageUrl': PropertySchema(
      id: 8,
      name: r'foodImageUrl',
      type: IsarType.string,
    ),
    r'foodName': PropertySchema(
      id: 9,
      name: r'foodName',
      type: IsarType.string,
    ),
    r'proteinGPerServing': PropertySchema(
      id: 10,
      name: r'proteinGPerServing',
      type: IsarType.double,
    ),
    r'servingSizeG': PropertySchema(
      id: 11,
      name: r'servingSizeG',
      type: IsarType.double,
    ),
    r'sodiumMgPerServing': PropertySchema(
      id: 12,
      name: r'sodiumMgPerServing',
      type: IsarType.double,
    ),
    r'sugarGPerServing': PropertySchema(
      id: 13,
      name: r'sugarGPerServing',
      type: IsarType.double,
    )
  },
  estimateSize: _isarLoggedEntryEstimateSize,
  serialize: _isarLoggedEntrySerialize,
  deserialize: _isarLoggedEntryDeserialize,
  deserializeProp: _isarLoggedEntryDeserializeProp,
);

int _isarLoggedEntryEstimateSize(
  IsarLoggedEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entryId.length * 3;
  {
    final value = object.foodBrand;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.foodId.length * 3;
  {
    final value = object.foodImageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.foodName.length * 3;
  return bytesCount;
}

void _isarLoggedEntrySerialize(
  IsarLoggedEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.caloriesPerServing);
  writer.writeDouble(offsets[1], object.carbsGPerServing);
  writer.writeDouble(offsets[2], object.consumedGrams);
  writer.writeString(offsets[3], object.entryId);
  writer.writeDouble(offsets[4], object.fatGPerServing);
  writer.writeDouble(offsets[5], object.fiberGPerServing);
  writer.writeString(offsets[6], object.foodBrand);
  writer.writeString(offsets[7], object.foodId);
  writer.writeString(offsets[8], object.foodImageUrl);
  writer.writeString(offsets[9], object.foodName);
  writer.writeDouble(offsets[10], object.proteinGPerServing);
  writer.writeDouble(offsets[11], object.servingSizeG);
  writer.writeDouble(offsets[12], object.sodiumMgPerServing);
  writer.writeDouble(offsets[13], object.sugarGPerServing);
}

IsarLoggedEntry _isarLoggedEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarLoggedEntry();
  object.caloriesPerServing = reader.readDouble(offsets[0]);
  object.carbsGPerServing = reader.readDouble(offsets[1]);
  object.consumedGrams = reader.readDouble(offsets[2]);
  object.entryId = reader.readString(offsets[3]);
  object.fatGPerServing = reader.readDouble(offsets[4]);
  object.fiberGPerServing = reader.readDouble(offsets[5]);
  object.foodBrand = reader.readStringOrNull(offsets[6]);
  object.foodId = reader.readString(offsets[7]);
  object.foodImageUrl = reader.readStringOrNull(offsets[8]);
  object.foodName = reader.readString(offsets[9]);
  object.proteinGPerServing = reader.readDouble(offsets[10]);
  object.servingSizeG = reader.readDouble(offsets[11]);
  object.sodiumMgPerServing = reader.readDouble(offsets[12]);
  object.sugarGPerServing = reader.readDouble(offsets[13]);
  return object;
}

P _isarLoggedEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarLoggedEntryQueryFilter
    on QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QFilterCondition> {
  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      caloriesPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caloriesPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      caloriesPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caloriesPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      caloriesPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caloriesPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      caloriesPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caloriesPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      carbsGPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carbsGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      carbsGPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carbsGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      carbsGPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carbsGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      carbsGPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carbsGPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      consumedGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consumedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      consumedGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consumedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      consumedGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consumedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      consumedGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consumedGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      entryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fatGPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fatGPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fatGPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fatGPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatGPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fiberGPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fiberGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fiberGPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fiberGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fiberGPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fiberGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      fiberGPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fiberGPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foodBrand',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foodBrand',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodBrand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodBrand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodBrand',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodBrandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodBrand',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodIdEqualTo(
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodIdBetween(
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foodImageUrl',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foodImageUrl',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      foodNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodName',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      proteinGPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proteinGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      proteinGPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proteinGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      proteinGPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proteinGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      proteinGPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proteinGPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
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

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sodiumMgPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sodiumMgPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sodiumMgPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sodiumMgPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sodiumMgPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sodiumMgPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sodiumMgPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sodiumMgPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sugarGPerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sugarGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sugarGPerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sugarGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sugarGPerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sugarGPerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QAfterFilterCondition>
      sugarGPerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sugarGPerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension IsarLoggedEntryQueryObject
    on QueryBuilder<IsarLoggedEntry, IsarLoggedEntry, QFilterCondition> {}
