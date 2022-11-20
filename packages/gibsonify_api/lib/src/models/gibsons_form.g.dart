// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gibsons_form.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const GibsonsFormSchema = Schema(
  name: r'GibsonsForm',
  id: 4133005118063700428,
  properties: {
    r'comments': PropertySchema(
      id: 0,
      name: r'comments',
      type: IsarType.string,
    ),
    r'employeeNumber': PropertySchema(
      id: 1,
      name: r'employeeNumber',
      type: IsarType.string,
    ),
    r'finished': PropertySchema(
      id: 2,
      name: r'finished',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'interviewDate': PropertySchema(
      id: 4,
      name: r'interviewDate',
      type: IsarType.string,
    ),
    r'interviewEndTime': PropertySchema(
      id: 5,
      name: r'interviewEndTime',
      type: IsarType.string,
    ),
    r'interviewFinishedInOneVisit': PropertySchema(
      id: 6,
      name: r'interviewFinishedInOneVisit',
      type: IsarType.string,
    ),
    r'interviewOutcome': PropertySchema(
      id: 7,
      name: r'interviewOutcome',
      type: IsarType.string,
    ),
    r'interviewOutcomeNotCompletedReason': PropertySchema(
      id: 8,
      name: r'interviewOutcomeNotCompletedReason',
      type: IsarType.string,
    ),
    r'interviewStartTime': PropertySchema(
      id: 9,
      name: r'interviewStartTime',
      type: IsarType.string,
    ),
    r'pictureChartCollected': PropertySchema(
      id: 10,
      name: r'pictureChartCollected',
      type: IsarType.string,
    ),
    r'pictureChartNotCollectedReason': PropertySchema(
      id: 11,
      name: r'pictureChartNotCollectedReason',
      type: IsarType.string,
    ),
    r'recallDay': PropertySchema(
      id: 12,
      name: r'recallDay',
      type: IsarType.string,
    ),
    r'secondInterviewVisitDate': PropertySchema(
      id: 13,
      name: r'secondInterviewVisitDate',
      type: IsarType.string,
    ),
    r'secondVisitReason': PropertySchema(
      id: 14,
      name: r'secondVisitReason',
      type: IsarType.string,
    )
  },
  estimateSize: _gibsonsFormEstimateSize,
  serialize: _gibsonsFormSerialize,
  deserialize: _gibsonsFormDeserialize,
  deserializeProp: _gibsonsFormDeserializeProp,
);

int _gibsonsFormEstimateSize(
  GibsonsForm object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comments;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.employeeNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.interviewDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewEndTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewFinishedInOneVisit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewOutcome;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewOutcomeNotCompletedReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewStartTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pictureChartCollected;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pictureChartNotCollectedReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recallDay;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.secondInterviewVisitDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.secondVisitReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _gibsonsFormSerialize(
  GibsonsForm object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.comments);
  writer.writeString(offsets[1], object.employeeNumber);
  writer.writeBool(offsets[2], object.finished);
  writer.writeString(offsets[3], object.id);
  writer.writeString(offsets[4], object.interviewDate);
  writer.writeString(offsets[5], object.interviewEndTime);
  writer.writeString(offsets[6], object.interviewFinishedInOneVisit);
  writer.writeString(offsets[7], object.interviewOutcome);
  writer.writeString(offsets[8], object.interviewOutcomeNotCompletedReason);
  writer.writeString(offsets[9], object.interviewStartTime);
  writer.writeString(offsets[10], object.pictureChartCollected);
  writer.writeString(offsets[11], object.pictureChartNotCollectedReason);
  writer.writeString(offsets[12], object.recallDay);
  writer.writeString(offsets[13], object.secondInterviewVisitDate);
  writer.writeString(offsets[14], object.secondVisitReason);
}

GibsonsForm _gibsonsFormDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GibsonsForm(
    comments: reader.readStringOrNull(offsets[0]),
    employeeNumber: reader.readStringOrNull(offsets[1]),
    finished: reader.readBoolOrNull(offsets[2]) ?? false,
    interviewDate: reader.readStringOrNull(offsets[4]),
    interviewEndTime: reader.readStringOrNull(offsets[5]),
    interviewFinishedInOneVisit: reader.readStringOrNull(offsets[6]),
    interviewOutcome: reader.readStringOrNull(offsets[7]),
    interviewOutcomeNotCompletedReason: reader.readStringOrNull(offsets[8]),
    interviewStartTime: reader.readStringOrNull(offsets[9]),
    pictureChartCollected: reader.readStringOrNull(offsets[10]),
    pictureChartNotCollectedReason: reader.readStringOrNull(offsets[11]),
    recallDay: reader.readStringOrNull(offsets[12]),
    secondInterviewVisitDate: reader.readStringOrNull(offsets[13]),
    secondVisitReason: reader.readStringOrNull(offsets[14]),
  );
  return object;
}

P _gibsonsFormDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GibsonsFormQueryFilter
    on QueryBuilder<GibsonsForm, GibsonsForm, QFilterCondition> {
  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comments',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comments',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> commentsEqualTo(
    String? value, {
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsGreaterThan(
    String? value, {
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsLessThan(
    String? value, {
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> commentsBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsEndsWith(
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> commentsMatches(
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

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comments',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      commentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comments',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'employeeNumber',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'employeeNumber',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      employeeNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> finishedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finished',
        value: value,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewDate',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewDate',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewDate',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewDate',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewEndTime',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewEndTime',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewEndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewEndTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewEndTime',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewEndTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewEndTime',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewFinishedInOneVisit',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewFinishedInOneVisit',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewFinishedInOneVisit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewFinishedInOneVisit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewFinishedInOneVisit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewFinishedInOneVisit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewFinishedInOneVisit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewFinishedInOneVisit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewFinishedInOneVisit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewFinishedInOneVisit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewFinishedInOneVisit',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewFinishedInOneVisitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewFinishedInOneVisit',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewOutcome',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewOutcome',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewOutcome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewOutcome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewOutcome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewOutcome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewOutcome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewOutcome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewOutcome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewOutcome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewOutcome',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewOutcome',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewOutcomeNotCompletedReason',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewOutcomeNotCompletedReason',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewOutcomeNotCompletedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewOutcomeNotCompletedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewOutcomeNotCompletedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewOutcomeNotCompletedReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewOutcomeNotCompletedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewOutcomeNotCompletedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewOutcomeNotCompletedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewOutcomeNotCompletedReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewOutcomeNotCompletedReason',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewOutcomeNotCompletedReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewOutcomeNotCompletedReason',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewStartTime',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewStartTime',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewStartTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewStartTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewStartTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewStartTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewStartTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewStartTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewStartTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewStartTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewStartTime',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      interviewStartTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewStartTime',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pictureChartCollected',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pictureChartCollected',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pictureChartCollected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pictureChartCollected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pictureChartCollected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pictureChartCollected',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pictureChartCollected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pictureChartCollected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pictureChartCollected',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pictureChartCollected',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pictureChartCollected',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartCollectedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pictureChartCollected',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pictureChartNotCollectedReason',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pictureChartNotCollectedReason',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pictureChartNotCollectedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pictureChartNotCollectedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pictureChartNotCollectedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pictureChartNotCollectedReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pictureChartNotCollectedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pictureChartNotCollectedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pictureChartNotCollectedReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pictureChartNotCollectedReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pictureChartNotCollectedReason',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      pictureChartNotCollectedReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pictureChartNotCollectedReason',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recallDay',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recallDay',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recallDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recallDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recallDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recallDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recallDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recallDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recallDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recallDay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recallDay',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      recallDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recallDay',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secondInterviewVisitDate',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secondInterviewVisitDate',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondInterviewVisitDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondInterviewVisitDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondInterviewVisitDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondInterviewVisitDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondInterviewVisitDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondInterviewVisitDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondInterviewVisitDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondInterviewVisitDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondInterviewVisitDate',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondInterviewVisitDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondInterviewVisitDate',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'secondVisitReason',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'secondVisitReason',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondVisitReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondVisitReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondVisitReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondVisitReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondVisitReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondVisitReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondVisitReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondVisitReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondVisitReason',
        value: '',
      ));
    });
  }

  QueryBuilder<GibsonsForm, GibsonsForm, QAfterFilterCondition>
      secondVisitReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondVisitReason',
        value: '',
      ));
    });
  }
}

extension GibsonsFormQueryObject
    on QueryBuilder<GibsonsForm, GibsonsForm, QFilterCondition> {}
