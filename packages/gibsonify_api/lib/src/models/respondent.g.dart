// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respondent.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const RespondentSchema = Schema(
  name: r'Respondent',
  id: -2873524172455157742,
  properties: {
    r'anthropometrics': PropertySchema(
      id: 0,
      name: r'anthropometrics',
      type: IsarType.objectList,
      target: r'Anthropometrics',
    ),
    r'collections': PropertySchema(
      id: 1,
      name: r'collections',
      type: IsarType.objectList,
      target: r'GibsonsForm',
    ),
    r'comments': PropertySchema(
      id: 2,
      name: r'comments',
      type: IsarType.string,
    ),
    r'dateOfBirth': PropertySchema(
      id: 3,
      name: r'dateOfBirth',
      type: IsarType.dateTime,
    ),
    r'literacyLevel': PropertySchema(
      id: 4,
      name: r'literacyLevel',
      type: IsarType.int,
      enumMap: _RespondentliteracyLevelEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'occupation': PropertySchema(
      id: 6,
      name: r'occupation',
      type: IsarType.int,
      enumMap: _RespondentoccupationEnumValueMap,
    ),
    r'phoneNumber': PropertySchema(
      id: 7,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
    r'sex': PropertySchema(
      id: 8,
      name: r'sex',
      type: IsarType.int,
      enumMap: _RespondentsexEnumValueMap,
    )
  },
  estimateSize: _respondentEstimateSize,
  serialize: _respondentSerialize,
  deserialize: _respondentDeserialize,
  deserializeProp: _respondentDeserializeProp,
);

int _respondentEstimateSize(
  Respondent object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.anthropometrics.length * 3;
  {
    final offsets = allOffsets[Anthropometrics]!;
    for (var i = 0; i < object.anthropometrics.length; i++) {
      final value = object.anthropometrics[i];
      bytesCount +=
          AnthropometricsSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.collections.length * 3;
  {
    final offsets = allOffsets[GibsonsForm]!;
    for (var i = 0; i < object.collections.length; i++) {
      final value = object.collections[i];
      bytesCount += GibsonsFormSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.comments.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.phoneNumber.length * 3;
  return bytesCount;
}

void _respondentSerialize(
  Respondent object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Anthropometrics>(
    offsets[0],
    allOffsets,
    AnthropometricsSchema.serialize,
    object.anthropometrics,
  );
  writer.writeObjectList<GibsonsForm>(
    offsets[1],
    allOffsets,
    GibsonsFormSchema.serialize,
    object.collections,
  );
  writer.writeString(offsets[2], object.comments);
  writer.writeDateTime(offsets[3], object.dateOfBirth);
  writer.writeInt(offsets[4], object.literacyLevel?.index);
  writer.writeString(offsets[5], object.name);
  writer.writeInt(offsets[6], object.occupation?.index);
  writer.writeString(offsets[7], object.phoneNumber);
  writer.writeInt(offsets[8], object.sex?.index);
}

Respondent _respondentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Respondent(
    anthropometrics: reader.readObjectList<Anthropometrics>(
          offsets[0],
          AnthropometricsSchema.deserialize,
          allOffsets,
          Anthropometrics(),
        ) ??
        const [],
    collections: reader.readObjectList<GibsonsForm>(
          offsets[1],
          GibsonsFormSchema.deserialize,
          allOffsets,
          GibsonsForm(),
        ) ??
        const [],
    comments: reader.readStringOrNull(offsets[2]) ?? "",
    dateOfBirth: reader.readDateTimeOrNull(offsets[3]),
    literacyLevel:
        _RespondentliteracyLevelValueEnumMap[reader.readIntOrNull(offsets[4])],
    name: reader.readStringOrNull(offsets[5]) ?? "",
    occupation:
        _RespondentoccupationValueEnumMap[reader.readIntOrNull(offsets[6])],
    phoneNumber: reader.readStringOrNull(offsets[7]) ?? "",
    sex: _RespondentsexValueEnumMap[reader.readIntOrNull(offsets[8])],
  );
  return object;
}

P _respondentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Anthropometrics>(
            offset,
            AnthropometricsSchema.deserialize,
            allOffsets,
            Anthropometrics(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readObjectList<GibsonsForm>(
            offset,
            GibsonsFormSchema.deserialize,
            allOffsets,
            GibsonsForm(),
          ) ??
          const []) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (_RespondentliteracyLevelValueEnumMap[
          reader.readIntOrNull(offset)]) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 6:
      return (_RespondentoccupationValueEnumMap[reader.readIntOrNull(offset)])
          as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 8:
      return (_RespondentsexValueEnumMap[reader.readIntOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RespondentliteracyLevelEnumValueMap = {
  'illiterate': 0,
  'readWrite': 1,
  'readOnly': 2,
  'signatureOnly': 3,
};
const _RespondentliteracyLevelValueEnumMap = {
  0: LiteracyLevel.illiterate,
  1: LiteracyLevel.readWrite,
  2: LiteracyLevel.readOnly,
  3: LiteracyLevel.signatureOnly,
};
const _RespondentoccupationEnumValueMap = {
  'domestic': 0,
  'farmer': 1,
  'agriculturalLabour': 2,
  'casualLabour': 3,
  'mgnrega': 4,
  'salariedNonAgricultural': 5,
  'ownAccountEmployment': 6,
  'collectiveNonAgricultural': 7,
  'unableToWork': 8,
  'student': 9,
  'salariedGovernment': 10,
  'other': 11,
};
const _RespondentoccupationValueEnumMap = {
  0: Occupation.domestic,
  1: Occupation.farmer,
  2: Occupation.agriculturalLabour,
  3: Occupation.casualLabour,
  4: Occupation.mgnrega,
  5: Occupation.salariedNonAgricultural,
  6: Occupation.ownAccountEmployment,
  7: Occupation.collectiveNonAgricultural,
  8: Occupation.unableToWork,
  9: Occupation.student,
  10: Occupation.salariedGovernment,
  11: Occupation.other,
};
const _RespondentsexEnumValueMap = {
  'male': 0,
  'female': 1,
};
const _RespondentsexValueEnumMap = {
  0: Sex.male,
  1: Sex.female,
};

extension RespondentQueryFilter
    on QueryBuilder<Respondent, Respondent, QFilterCondition> {
  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'anthropometrics',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'anthropometrics',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'anthropometrics',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'anthropometrics',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'anthropometrics',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'anthropometrics',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'collections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> commentsEqualTo(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      commentsGreaterThan(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> commentsLessThan(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> commentsBetween(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      commentsStartsWith(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> commentsEndsWith(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> commentsContains(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> commentsMatches(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      commentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comments',
        value: '',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      commentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comments',
        value: '',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      dateOfBirthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      dateOfBirthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      dateOfBirthEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      dateOfBirthGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      dateOfBirthLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      dateOfBirthBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfBirth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      literacyLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'literacyLevel',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      literacyLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'literacyLevel',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      literacyLevelEqualTo(LiteracyLevel? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'literacyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      literacyLevelGreaterThan(
    LiteracyLevel? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'literacyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      literacyLevelLessThan(
    LiteracyLevel? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'literacyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      literacyLevelBetween(
    LiteracyLevel? lower,
    LiteracyLevel? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'literacyLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      occupationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'occupation',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      occupationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'occupation',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> occupationEqualTo(
      Occupation? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occupation',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      occupationGreaterThan(
    Occupation? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'occupation',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      occupationLessThan(
    Occupation? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'occupation',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> occupationBetween(
    Occupation? lower,
    Occupation? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'occupation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> sexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sex',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> sexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sex',
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> sexEqualTo(
      Sex? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sex',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> sexGreaterThan(
    Sex? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sex',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> sexLessThan(
    Sex? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sex',
        value: value,
      ));
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition> sexBetween(
    Sex? lower,
    Sex? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RespondentQueryObject
    on QueryBuilder<Respondent, Respondent, QFilterCondition> {
  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      anthropometricsElement(FilterQuery<Anthropometrics> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'anthropometrics');
    });
  }

  QueryBuilder<Respondent, Respondent, QAfterFilterCondition>
      collectionsElement(FilterQuery<GibsonsForm> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'collections');
    });
  }
}
