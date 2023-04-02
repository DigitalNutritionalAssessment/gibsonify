import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:hive/hive.dart';

class HiveRepository {
  final Box<Household> householdBox;
  final Box<Survey> surveyBox;

  HiveRepository._({required this.householdBox, required this.surveyBox});

  static Future<HiveRepository> create() async {
    final householdsBox = await Hive.openBox<Household>('households');
    final surveysBox = await Hive.openBox<Survey>('surveys');

    return HiveRepository._(
      householdBox: householdsBox,
      surveyBox: surveysBox,
    );
  }

  Iterable<Household> readHouseholds() {
    return householdBox.values;
  }

  Household? readHousehold(String id) {
    return householdBox.get(id);
  }

  void saveNewHousehold(Household household) {
    householdBox.put(household.householdId, household);
  }

  void deleteHousehold(String householdId) {
    householdBox.delete(householdId);
  }

  Iterable<Survey> readSurveys() {
    return surveyBox.values;
  }

  Survey? readSurvey(String surveyId) {
    return surveyBox.get(surveyId);
  }

  void saveSurvey(Survey survey) {
    surveyBox.put(survey.surveyId, survey);
  }

  void deleteSurvey(String surveyId) {
    surveyBox.delete(surveyId);
  }
}
