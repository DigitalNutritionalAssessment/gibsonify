import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:uuid/uuid.dart';

Recipe Function() sampleRecipe = () => Recipe(
    date: "2023-05-01",
    name: "Roast chicken",
    probes: [
      Probe(name: "Half chicken?", probeOptions: [
        ProbeOption(option: "Yes", id: "1"),
        ProbeOption(option: "No", id: "2")
      ])
    ],
    employeeNumber: "FP361",
    fctId: sampleSurvey().fctId,
    surveyId: sampleSurvey().surveyId,
    ingredients: [
      Ingredient(
          description: "",
          fctFoodItemId: "N003",
          fctFoodItemName: "Chicken, poultry, breast, skinless",
          cookingState: "Roasted with oil",
          id: const Uuid().v4(),
          saved: true,
          measurements: [
            Measurement(
              id: const Uuid().v4(),
              method: "Direct weight",
              unit: "Grams",
              value: "100",
            )
          ])
    ],
    measurements: [
      Measurement(
        id: const Uuid().v4(),
        method: "Direct weight",
        unit: "Grams",
        value: "100",
      )
    ],
    number: const Uuid().v4(),
    saved: true,
    type: "Standard Recipe");

Survey Function() sampleSurvey = () => Survey(
    surveyId: "TEST1",
    fctId: "ifct2017",
    name: "Test survey",
    description: "Cambridge 18-30 M",
    comments: "Testing purposes only",
    country: "United Kingdom",
    geoArea: "52.204381,0.125866,4858,11.6",
    requiredSex: Sex.male,
    minAge: 18,
    maxAge: 30);

final respondentId = const Uuid().v4();
final collectionId = const Uuid().v4();
final anthropId = const Uuid().v4();

Household Function() sampleHousehold = () => Household(
    householdId: "HH42A2022001",
    sensitizationDate: DateTime(2023, 5, 1),
    geoLocation: "52.204381,0.125866",
    comments: "My household",
    respondents: {
      respondentId: Respondent(
          id: respondentId,
          name: "Faizaan Pervaiz",
          phoneNumber: "+447000123456",
          dateOfBirth: DateTime(2000, 1, 1),
          sex: Sex.male,
          literacyLevel: LiteracyLevel.readWrite,
          occupation: Occupation.student,
          comments: "Myself",
          collections: {
            collectionId: GibsonsForm(
                id: collectionId,
                physioStatus: PhysioStatus.notApplicable,
                finished: false,
                comments: "Test collection",
                interviewDate: "2023-05-03",
                interviewEndTime: "15:05",
                interviewStartTime: "14:15",
                interviewFinishedInOneVisit: "Yes",
                interviewOutcome: "Completed",
                pictureChartCollected: "Yes",
                recallDay: "Normal",
                surveyId: sampleSurvey().surveyId,
                foodItems: [
                  FoodItem(
                      confirmed: true,
                      id: const Uuid().v4(),
                      measurements: [
                        Measurement(
                          id: const Uuid().v4(),
                          method: "Direct weight",
                          unit: "Grams",
                          value: "100",
                        )
                      ],
                      name: "Roast chicken",
                      preparationMethod: "Roasted with oil",
                      recipe: sampleRecipe(),
                      source: "Home",
                      timePeriod: "Morning"),
                ],
                metadata: Metadata.create(createdBy: "FP361")
                    .modify(lastModifiedBy: "FP361"))
          },
          anthropometrics: [
            Anthropometrics(
                date: DateTime(2023, 5, 1), height: 100, weight: 100)
          ],
          metadata: Metadata.create(createdBy: "FP361")
              .modify(lastModifiedBy: "FP361"))
    },
    metadata:
        Metadata.create(createdBy: "FP361").modify(lastModifiedBy: "FP361"));

void overwriteWithSampleData(
    HiveRepository hiveRepository, GibsonifyRepository gibsonifyRepository) {
  if (kDebugMode) {
    for (final household in hiveRepository.readHouseholds()) {
      hiveRepository.deleteHousehold(household.householdId);
    }

    hiveRepository.saveNewHousehold(sampleHousehold());

    for (final survey in hiveRepository.readSurveys()) {
      hiveRepository.deleteSurvey(survey.surveyId);
    }

    hiveRepository.saveSurvey(sampleSurvey());

    gibsonifyRepository.saveRecipes([sampleRecipe()]);
  }
}
