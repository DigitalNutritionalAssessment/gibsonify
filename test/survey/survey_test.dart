import 'package:flutter_test/flutter_test.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

import '../utils.dart';

void main() {
  group('surveys', () {
    late Survey survey;
    late Household household;

    setUp(() {
      survey = mockSurvey();
      household = mockHousehold();
    });

    test('allow survey delete if there are no associated collections', () {
      survey = survey.copyWith(surveyId: "S2");
      expect(
          allowSurveyDelete(surveyId: survey.surveyId, households: [household]),
          isTrue);
    });

    test('disallow survey delete if there are associated collections', () {
      expect(
          allowSurveyDelete(surveyId: survey.surveyId, households: [household]),
          isFalse);
    });
  });
}
