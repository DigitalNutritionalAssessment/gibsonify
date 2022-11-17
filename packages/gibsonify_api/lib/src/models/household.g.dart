// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetHouseholdCollection on Isar {
  IsarCollection<Household> get households => this.collection();
}

const HouseholdSchema = CollectionSchema(
  name: r'Household',
  id: -5629198286502423862,
  properties: {
    r'comments': PropertySchema(
      id: 0,
      name: r'comments',
      type: IsarType.string,
    ),
    r'geoLocation': PropertySchema(
      id: 1,
      name: r'geoLocation',
      type: IsarType.string,
    ),
    r'householdId': PropertySchema(
      id: 2,
      name: r'householdId',
      type: IsarType.string,
    ),
    r'respondents': PropertySchema(
      id: 3,
      name: r'respondents',
      type: IsarType.objectList,
      target: r'Respondent',
    ),
    r'sensitizationDate': PropertySchema(
      id: 4,
      name: r'sensitizationDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _householdEstimateSize,
  serialize: _householdSerialize,
  deserialize: _householdDeserialize,
  deserializeProp: _householdDeserializeProp,
  idName: r'id',
  indexes: {
    r'householdId': IndexSchema(
      id: 8941485815717012049,
      name: r'householdId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'householdId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Respondent': RespondentSchema},
  getId: _householdGetId,
  getLinks: _householdGetLinks,
  attach: _householdAttach,
  version: '3.0.4',
);

int _householdEstimateSize(
  Household object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.comments.length * 3;
  bytesCount += 3 + object.geoLocation.length * 3;
  bytesCount += 3 + object.householdId.length * 3;
  bytesCount += 3 + object.respondents.length * 3;
  {
    final offsets = allOffsets[Respondent]!;
    for (var i = 0; i < object.respondents.length; i++) {
      final value = object.respondents[i];
      bytesCount += RespondentSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _householdSerialize(
  Household object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.comments);
  writer.writeString(offsets[1], object.geoLocation);
  writer.writeString(offsets[2], object.householdId);
  writer.writeObjectList<Respondent>(
    offsets[3],
    allOffsets,
    RespondentSchema.serialize,
    object.respondents,
  );
  writer.writeDateTime(offsets[4], object.sensitizationDate);
}

Household _householdDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Household(
    comments: reader.readString(offsets[0]),
    geoLocation: reader.readString(offsets[1]),
    householdId: reader.readString(offsets[2]),
    sensitizationDate: reader.readDateTime(offsets[4]),
  );
  object.id = id;
  return object;
}

P _householdDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readObjectList<Respondent>(
            offset,
            RespondentSchema.deserialize,
            allOffsets,
            Respondent(),
          ) ??
          []) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _householdGetId(Household object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _householdGetLinks(Household object) {
  return [];
}

void _householdAttach(IsarCollection<dynamic> col, Id id, Household object) {
  object.id = id;
}

extension HouseholdByIndex on IsarCollection<Household> {
  Future<Household?> getByHouseholdId(String householdId) {
    return getByIndex(r'householdId', [householdId]);
  }

  Household? getByHouseholdIdSync(String householdId) {
    return getByIndexSync(r'householdId', [householdId]);
  }

  Future<bool> deleteByHouseholdId(String householdId) {
    return deleteByIndex(r'householdId', [householdId]);
  }

  bool deleteByHouseholdIdSync(String householdId) {
    return deleteByIndexSync(r'householdId', [householdId]);
  }

  Future<List<Household?>> getAllByHouseholdId(List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'householdId', values);
  }

  List<Household?> getAllByHouseholdIdSync(List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'householdId', values);
  }

  Future<int> deleteAllByHouseholdId(List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'householdId', values);
  }

  int deleteAllByHouseholdIdSync(List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'householdId', values);
  }

  Future<Id> putByHouseholdId(Household object) {
    return putByIndex(r'householdId', object);
  }

  Id putByHouseholdIdSync(Household object, {bool saveLinks = true}) {
    return putByIndexSync(r'householdId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHouseholdId(List<Household> objects) {
    return putAllByIndex(r'householdId', objects);
  }

  List<Id> putAllByHouseholdIdSync(List<Household> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'householdId', objects, saveLinks: saveLinks);
  }
}

extension HouseholdQueryWhereSort
    on QueryBuilder<Household, Household, QWhere> {
  QueryBuilder<Household, Household, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HouseholdQueryWhere
    on QueryBuilder<Household, Household, QWhereClause> {
  QueryBuilder<Household, Household, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Household, Household, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Household, Household, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Household, Household, QAfterWhereClause> idBetween(
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

  QueryBuilder<Household, Household, QAfterWhereClause> householdIdEqualTo(
      String householdId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'householdId',
        value: [householdId],
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterWhereClause> householdIdNotEqualTo(
      String householdId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [],
              upper: [householdId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [householdId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [householdId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [],
              upper: [householdId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension HouseholdQueryFilter
    on QueryBuilder<Household, Household, QFilterCondition> {
  QueryBuilder<Household, Household, QAfterFilterCondition> commentsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comments',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> commentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comments',
        value: '',
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      commentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comments',
        value: '',
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> geoLocationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geoLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      geoLocationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'geoLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> geoLocationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'geoLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> geoLocationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'geoLocation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      geoLocationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'geoLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> geoLocationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'geoLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> geoLocationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'geoLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> geoLocationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'geoLocation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      geoLocationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geoLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      geoLocationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'geoLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> householdIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      householdIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> householdIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> householdIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'householdId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      householdIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> householdIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> householdIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> householdIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'householdId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      householdIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      householdIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Household, Household, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Household, Household, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Household, Household, QAfterFilterCondition>
      respondentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'respondents',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      respondentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'respondents',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      respondentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'respondents',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      respondentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'respondents',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      respondentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'respondents',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      respondentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'respondents',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      sensitizationDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sensitizationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      sensitizationDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sensitizationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      sensitizationDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sensitizationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Household, Household, QAfterFilterCondition>
      sensitizationDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sensitizationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HouseholdQueryObject
    on QueryBuilder<Household, Household, QFilterCondition> {
  QueryBuilder<Household, Household, QAfterFilterCondition> respondentsElement(
      FilterQuery<Respondent> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'respondents');
    });
  }
}

extension HouseholdQueryLinks
    on QueryBuilder<Household, Household, QFilterCondition> {}

extension HouseholdQuerySortBy on QueryBuilder<Household, Household, QSortBy> {
  QueryBuilder<Household, Household, QAfterSortBy> sortByComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> sortByCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> sortByGeoLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geoLocation', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> sortByGeoLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geoLocation', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> sortByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> sortByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> sortBySensitizationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitizationDate', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy>
      sortBySensitizationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitizationDate', Sort.desc);
    });
  }
}

extension HouseholdQuerySortThenBy
    on QueryBuilder<Household, Household, QSortThenBy> {
  QueryBuilder<Household, Household, QAfterSortBy> thenByComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenByCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenByGeoLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geoLocation', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenByGeoLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geoLocation', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy> thenBySensitizationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitizationDate', Sort.asc);
    });
  }

  QueryBuilder<Household, Household, QAfterSortBy>
      thenBySensitizationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitizationDate', Sort.desc);
    });
  }
}

extension HouseholdQueryWhereDistinct
    on QueryBuilder<Household, Household, QDistinct> {
  QueryBuilder<Household, Household, QDistinct> distinctByComments(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comments', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Household, Household, QDistinct> distinctByGeoLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'geoLocation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Household, Household, QDistinct> distinctByHouseholdId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'householdId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Household, Household, QDistinct> distinctBySensitizationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sensitizationDate');
    });
  }
}

extension HouseholdQueryProperty
    on QueryBuilder<Household, Household, QQueryProperty> {
  QueryBuilder<Household, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Household, String, QQueryOperations> commentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comments');
    });
  }

  QueryBuilder<Household, String, QQueryOperations> geoLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'geoLocation');
    });
  }

  QueryBuilder<Household, String, QQueryOperations> householdIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'householdId');
    });
  }

  QueryBuilder<Household, List<Respondent>, QQueryOperations>
      respondentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'respondents');
    });
  }

  QueryBuilder<Household, DateTime, QQueryOperations>
      sensitizationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensitizationDate');
    });
  }
}
