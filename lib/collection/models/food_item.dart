// TODO: look into making Food a child of Equatable
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

class FoodItem extends Equatable {
  FoodItem(
      {this.name = const Name.pure(),
      this.timePeriod = const TimePeriod.pure(),
      String? id})
      : id = id ?? const Uuid().v4();

  final Name name;
  final TimePeriod timePeriod;
  final String id;

  // This was used in Equatable-derived implementation, delete if not used later

  FoodItem copyWith({Name? name, TimePeriod? timePeriod, String? id}) {
    return FoodItem(
        name: name ?? this.name,
        timePeriod: timePeriod ?? this.timePeriod,
        id: id ?? this.id);
  }

  @override
  List<Object> get props => [name, timePeriod, id];
}

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true ? null : NameValidationError.invalid;
  }
}

enum TimePeriodValidationError { invalid }

class TimePeriod extends FormzInput<String, TimePeriodValidationError> {
  const TimePeriod.pure() : super.pure('');
  const TimePeriod.dirty([String value = '']) : super.dirty(value);

  final _allowedTimePeriod = const ['morning', 'afternoon', 'evening', 'night'];

  @override
  TimePeriodValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedTimePeriod.contains(_lowerCaseValue)
        ? null
        : TimePeriodValidationError.invalid;
  }
}
