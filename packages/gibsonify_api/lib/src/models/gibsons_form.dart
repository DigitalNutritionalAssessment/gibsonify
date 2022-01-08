import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:uuid/uuid.dart';

import 'food_item.dart';

class GibsonsForm extends Equatable {
  GibsonsForm(
      {String? id,
      this.householdId = const HouseholdId.pure(),
      this.respondentName = const RespondentName.pure(),
      this.respondentTelNumber = const RespondentTelNumber.pure(),
      this.sensitizationDate = const SensitizationDate.pure(),
      this.recallDay = const RecallDay.pure(),
      this.interviewDate = const InterviewDate.pure(),
      this.interviewStartTime = const InterviewStartTime.pure(),
      this.interviewEndTime = const InterviewEndTime.pure(),
      this.interviewOutcome = const InterviewOutcome.pure(),
      this.comments = const Comments.pure(),
      this.foodItems = const <FoodItem>[]})
      : id = id ?? const Uuid().v4();

  final String id;
  final HouseholdId householdId;
  final RespondentName respondentName;
  final RespondentTelNumber respondentTelNumber;
  final SensitizationDate sensitizationDate;
  final RecallDay recallDay;
  final InterviewDate interviewDate;
  final InterviewStartTime interviewStartTime;
  final InterviewEndTime interviewEndTime;
  final InterviewOutcome interviewOutcome;
  final Comments comments;
  final List<FoodItem> foodItems;

  // TODO: add other fields from physical Gibson's form:
  // end of interview, did complete interview in one visit? (bool),
  // date of second visit, reason for second visit, final outcome of interview,
  // reason for incomplete interview, supervisor comments.

  // TODO: implement code generation JSON serialization using json_serializable
  // and/or json_annotation

  GibsonsForm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        householdId = HouseholdId.fromJson(json['householdId']),
        respondentName = RespondentName.fromJson(json['respondentName']),
        respondentTelNumber =
            RespondentTelNumber.fromJson(json['respondentTelNumber']),
        sensitizationDate =
            SensitizationDate.fromJson(json['sensitizationDate']),
        recallDay = RecallDay.fromJson(json['recallDay']),
        interviewDate = InterviewDate.fromJson(json['interviewDate']),
        interviewStartTime =
            InterviewStartTime.fromJson(json['interviewStartTime']),
        interviewEndTime = InterviewEndTime.fromJson(json['interviewEndTime']),
        interviewOutcome = InterviewOutcome.fromJson(json['interviewOutcome']),
        comments = Comments.fromJson(json['comments']),
        foodItems = _jsonDecodeFoodItems(json['foodItems']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['householdId'] = householdId.toJson();
    data['respondentName'] = respondentName.toJson();
    data['respondentTelNumber'] = respondentTelNumber.toJson();
    data['sensitizationDate'] = sensitizationDate.toJson();
    data['recallDay'] = recallDay.toJson();
    data['interviewDate'] = interviewDate.toJson();
    data['interviewStartTime'] = interviewStartTime.toJson();
    data['interviewEndTime'] = interviewEndTime.toJson();
    data['interviewOutcome'] = interviewOutcome.toJson();
    data['comments'] = comments.toJson();
    data['foodItems'] = jsonEncode(foodItems); // This calls toJson on each one
    return data;
  }

  GibsonsForm copyWith(
      {String? id,
      HouseholdId? householdId,
      RespondentName? respondentName,
      RespondentTelNumber? respondentTelNumber,
      SensitizationDate? sensitizationDate,
      RecallDay? recallDay,
      InterviewDate? interviewDate,
      InterviewStartTime? interviewStartTime,
      InterviewEndTime? interviewEndTime,
      InterviewOutcome? interviewOutcome,
      Comments? comments,
      List<FoodItem>? foodItems}) {
    return GibsonsForm(
        id: id ?? this.id,
        householdId: householdId ?? this.householdId,
        respondentName: respondentName ?? this.respondentName,
        respondentTelNumber: respondentTelNumber ?? this.respondentTelNumber,
        sensitizationDate: sensitizationDate ?? this.sensitizationDate,
        recallDay: recallDay ?? this.recallDay,
        interviewDate: interviewDate ?? this.interviewDate,
        interviewStartTime: interviewStartTime ?? this.interviewStartTime,
        interviewEndTime: interviewEndTime ?? this.interviewEndTime,
        interviewOutcome: interviewOutcome ?? this.interviewOutcome,
        comments: comments ?? this.comments,
        foodItems: foodItems ?? this.foodItems);
  }

  @override
  String toString() {
    return '\n *** \nGibson\'s Form:\n'
        'UUID: $id\n'
        'HouseholdID: $householdId\n'
        'Repondent Name: $respondentName\n'
        'Respondent Tel Number: $respondentTelNumber\n'
        'Sensitization Date: $sensitizationDate\n'
        'Recall Day: $recallDay\n'
        'Interview Date: $interviewDate\n'
        'Interview Start Time: $interviewStartTime\n'
        'Interview End Time: $interviewEndTime\n'
        'Interview Outcome: $interviewOutcome\n'
        'Comments: $comments\n'
        'Food Items: $foodItems'
        '\n *** \n';
  }

  @override
  List<Object> get props => [
        id,
        householdId,
        respondentName,
        respondentTelNumber,
        sensitizationDate,
        recallDay,
        interviewDate,
        interviewStartTime,
        interviewEndTime,
        interviewOutcome,
        comments,
        foodItems
      ];
}

List<FoodItem> _jsonDecodeFoodItems(jsonEncodedFoodItems) {
  List<dynamic> partiallyDecodedFoodItems = jsonDecode(jsonEncodedFoodItems);
  List<FoodItem> fullyDecodedFoodItems =
      partiallyDecodedFoodItems.map((e) => FoodItem.fromJson(e)).toList();
  return fullyDecodedFoodItems;
}

enum HouseholdIdValidationError { invalid }

class HouseholdId extends FormzInput<String, HouseholdIdValidationError> {
  const HouseholdId.pure() : super.pure('');
  const HouseholdId.dirty([String value = '']) : super.dirty(value);

  // TODO: Figure out a way to use the pure attribute or maybe drop
  // Formz completely. It might be easier to just have all these values
  // as strings and implement a couple of validator methods in GibsonsForm
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  HouseholdId.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  RespondentName.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  RespondentTelNumber.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  RespondentTelNumberValidationError? validator(String? value) {
    // TODO: Add (Regex?) number validation, currently only checks if not empty
    // also probably could be empty? So check if either empty or valid number
    return value?.isNotEmpty == true
        ? null
        : RespondentTelNumberValidationError.invalid;
  }
}

enum SensitizationDateValidationError { invalid }

class SensitizationDate
    extends FormzInput<String, SensitizationDateValidationError> {
  const SensitizationDate.pure() : super.pure('');
  const SensitizationDate.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  SensitizationDate.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  SensitizationDateValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : SensitizationDateValidationError.invalid;
  }
}

enum RecallDayValidationError { invalid }

class RecallDay extends FormzInput<String, RecallDayValidationError> {
  const RecallDay.pure() : super.pure('');
  const RecallDay.dirty([String value = '']) : super.dirty(value);

  // TODO: update when accepting custom strings for 'other'
  final _allowedRecallDay = const [
    'normal day',
    'sick day',
    'fasting day',
    'festival/religious day',
    'parties/functions day',
    'visitors/relatives',
    'other'
  ];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  RecallDay.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  RecallDayValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedRecallDay.contains(_lowerCaseValue)
        ? null
        : RecallDayValidationError.invalid;
  }
}

enum InterviewDateValidationError { invalid }

class InterviewDate extends FormzInput<String, InterviewDateValidationError> {
  const InterviewDate.pure() : super.pure('');
  const InterviewDate.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  InterviewDate.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  InterviewStartTime.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  InterviewStartTimeValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : InterviewStartTimeValidationError.invalid;
  }
}

enum InterviewEndTimeValidationError { invalid }

class InterviewEndTime
    extends FormzInput<String, InterviewEndTimeValidationError> {
  const InterviewEndTime.pure() : super.pure('');
  const InterviewEndTime.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  InterviewEndTime.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  InterviewEndTimeValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true
        ? null
        : InterviewEndTimeValidationError.invalid;
  }
}

enum InterviewOutcomeValidationError { invalid }

class InterviewOutcome
    extends FormzInput<String, InterviewOutcomeValidationError> {
  const InterviewOutcome.pure() : super.pure('');
  const InterviewOutcome.dirty([String value = '']) : super.dirty(value);

  // TODO: update when accepting custom strings for 'other'
  final _allowedRecallDay = const [
    'completed',
    'incomplete',
    'absent',
    'refused',
    'could not locate',
  ];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  InterviewOutcome.fromJson(Map<String, dynamic> json)
      : super.dirty(json['value']);

  @override
  InterviewOutcomeValidationError? validator(String? value) {
    final _lowerCaseValue = (value ?? '').toLowerCase();
    // TODO: refactor with a better null check
    return _allowedRecallDay.contains(_lowerCaseValue)
        ? null
        : InterviewOutcomeValidationError.invalid;
  }
}

enum CommentsValidationError { invalid }

class Comments extends FormzInput<String, CommentsValidationError> {
  const Comments.pure() : super.pure('');
  const Comments.dirty([String value = '']) : super.dirty(value);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['pure'] = pure.toString();
    return data;
  }

  Comments.fromJson(Map<String, dynamic> json) : super.dirty(json['value']);

  @override
  CommentsValidationError? validator(String? value) {
    // TODO: Add validation, currently only checks if not empty
    return value?.isNotEmpty == true ? null : CommentsValidationError.invalid;
  }
}
