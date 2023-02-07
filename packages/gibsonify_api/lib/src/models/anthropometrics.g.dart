// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anthropometrics.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const AnthropometricsSchema = Schema(
  name: r'Anthropometrics',
  id: -2851607001850966851,
  properties: {
    r'armLength': PropertySchema(
      id: 0,
      name: r'armLength',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'handSpan': PropertySchema(
      id: 2,
      name: r'handSpan',
      type: IsarType.double,
    ),
    r'height': PropertySchema(
      id: 3,
      name: r'height',
      type: IsarType.double,
    ),
    r'waist': PropertySchema(
      id: 4,
      name: r'waist',
      type: IsarType.double,
    ),
    r'weight': PropertySchema(
      id: 5,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _anthropometricsEstimateSize,
  serialize: _anthropometricsSerialize,
  deserialize: _anthropometricsDeserialize,
  deserializeProp: _anthropometricsDeserializeProp,
);

int _anthropometricsEstimateSize(
  Anthropometrics object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _anthropometricsSerialize(
  Anthropometrics object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.armLength);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDouble(offsets[2], object.handSpan);
  writer.writeDouble(offsets[3], object.height);
  writer.writeDouble(offsets[4], object.waist);
  writer.writeDouble(offsets[5], object.weight);
}

Anthropometrics _anthropometricsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Anthropometrics(
    armLength: reader.readDoubleOrNull(offsets[0]),
    date: reader.readDateTimeOrNull(offsets[1]),
    handSpan: reader.readDoubleOrNull(offsets[2]),
    height: reader.readDoubleOrNull(offsets[3]),
    waist: reader.readDoubleOrNull(offsets[4]),
    weight: reader.readDoubleOrNull(offsets[5]),
  );
  return object;
}

P _anthropometricsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AnthropometricsQueryFilter
    on QueryBuilder<Anthropometrics, Anthropometrics, QFilterCondition> {
  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      armLengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'armLength',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      armLengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'armLength',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      armLengthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'armLength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      armLengthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'armLength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      armLengthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'armLength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      armLengthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'armLength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      dateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      handSpanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'handSpan',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      handSpanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'handSpan',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      handSpanEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'handSpan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      handSpanGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'handSpan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      handSpanLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'handSpan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      handSpanBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'handSpan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      heightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      heightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      heightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      heightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      waistIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'waist',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      waistIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'waist',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      waistEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waist',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      waistGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waist',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      waistLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waist',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      waistBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      weightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      weightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      weightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anthropometrics, Anthropometrics, QAfterFilterCondition>
      weightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension AnthropometricsQueryObject
    on QueryBuilder<Anthropometrics, Anthropometrics, QFilterCondition> {}
