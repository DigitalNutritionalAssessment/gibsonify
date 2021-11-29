import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart'; // TODO: each gibsons form should have a unique uuid

import 'food_item.dart';

class GibsonsForm extends Equatable {
  GibsonsForm(
      {String? id,
      this.householdId = const HouseholdId.pure(),
      this.respondentName = const RespondentName.pure(),
      this.respondentTelNumber = const RespondentTelNumber.pure(),
      this.interviewDate = const InterviewDate.pure(),
      this.interviewStartTime = const InterviewStartTime.pure(),
      this.sensitizationStatus = FormzStatus.pure,
      this.foodItems = const <FoodItem>[]})
      : id = id ?? const Uuid().v4();

  final String id;
  final HouseholdId householdId;
  final RespondentName respondentName;
  final RespondentTelNumber respondentTelNumber;
  final InterviewDate interviewDate;
  final InterviewStartTime interviewStartTime;
  final FormzStatus sensitizationStatus;

  final List<FoodItem> foodItems;

  // TODO: add other fields from physical Gibson's form:
  // end of interview, did complete interview in one visit? (bool),
  // date of second visit, reason for second visit, final outcome of interview,
  // reason for incomplete interview, supervisor comments.
  // And also ask ICRISAT about date of sensitization visit and recall day code.

  GibsonsForm copyWith(
      {HouseholdId? householdId,
      RespondentName? respondentName,
      RespondentTelNumber? respondentTelNumber,
      InterviewDate? interviewDate,
      InterviewStartTime? interviewStartTime,
      FormzStatus? sensitizationStatus,
      List<FoodItem>? foodItems}) {
    return GibsonsForm(
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelNumber: respondentTelNumber ?? this.respondentTelNumber,
        interviewStartTime: interviewStartTime ?? this.interviewStartTime,
        interviewDate: interviewDate ?? this.interviewDate,
        sensitizationStatus: sensitizationStatus ?? this.sensitizationStatus,
        foodItems: foodItems ?? this.foodItems);
  }

  @override
  String toString() {
    return '\n *** \nGibson\'s Form:\n'
        'UUID: $id\n'
        'HouseholdID: $householdId\n'
        'Repondent Name: $respondentName\n'
        'Respondent Tel Number: $respondentTelNumber\n'
        'Interview Date: $interviewDate\n'
        'Interview Start Time: $interviewStartTime\n'
        'Sensitization Status: $sensitizationStatus\n'
        'Food Items: $foodItems'
        '\n *** \n';
  }

  @override
  List<Object> get props => [
        householdId,
        respondentName,
        respondentTelNumber,
        interviewDate,
        interviewStartTime,
        sensitizationStatus,
        foodItems
      ];
}

enum HouseholdIdValidationError { invalid }

class HouseholdId extends FormzInput<String, HouseholdIdValidationError> {
  const HouseholdId.pure() : super.pure('');
  const HouseholdId.dirty([String value = '']) : super.dirty(value);

  @override
  HouseholdIdValidationError? validator(String value) {
    // TODO: Add validation based on ICRISAT's criteria, currently
    // only checks if at least 2 symbols
    return value.length > 1 ? null : HouseholdIdValidationError.invalid;
  }
}

enum RespondentNameValidationError { invalid }

class RespondentName extends FormzInput<String, RespondentNameValidationError> {
  const RespondentName.pure() : super.pure('');
  const RespondentName.dirty([String value = '']) : super.dirty(value);

  @override
  RespondentNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : RespondentNameValidationError.invalid;
  }
}

enum RespondentTelNumberValidationError { invalid }

class RespondentTelNumber
    extends FormzInput<String, RespondentTelNumberValidationError> {
  const RespondentTelNumber.pure() : super.pure('');
  const RespondentTelNumber.dirty([String value = '']) : super.dirty(value);

  @override
  RespondentTelNumberValidationError? validator(String? value) {
    // TODO: Add (Regex?) number validation, currently only checks if not empty
    // also probably could be empty? So check if either empty or valid number
    return value?.isNotEmpty == true
        ? null
        : RespondentTelNumberValidationError.invalid;
  }
}

enum InterviewDateValidationError { invalid }

class InterviewDate extends FormzInput<String, InterviewDateValidationError> {
  const InterviewDate.pure() : super.pure('');
  const InterviewDate.dirty([String value = '']) : super.dirty(value);

  @override
  InterviewDateValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : InterviewDateValidationError.invalid;
  }
}

enum InterviewStartTimeValidationError { invalid }

class InterviewStartTime
    extends FormzInput<String, InterviewStartTimeValidationError> {
  const InterviewStartTime.pure() : super.pure('');
  const InterviewStartTime.dirty([String value = '']) : super.dirty(value);

  @override
  InterviewStartTimeValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : InterviewStartTimeValidationError.invalid;
  }
}
