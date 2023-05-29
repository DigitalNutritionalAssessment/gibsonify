import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:uuid/uuid.dart';

List<Recipe> Function() sampleRecipes = () => [
      Recipe(
          date: "2023-05-01",
          name: "Roast chicken and potatoes",
          probes: [
            Probe(name: "Chicken breast used?", probeOptions: [
              ProbeOption(option: "Yes", id: "1"),
              ProbeOption(option: "No", id: "2")
            ])
          ],
          employeeNumber: "FP361",
          fctId: "ifct2017",
          surveyId: "TEST1",
          ingredients: [
            Ingredient(
                description: "Roast chicken breast",
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
                ]),
            Ingredient(
                description: "Roast potato",
                fctFoodItemId: "F006",
                fctFoodItemName: "Potato, brown skin, big",
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
              value: "200",
            )
          ],
          number: const Uuid().v4(),
          saved: true,
          type: "Standard Recipe"),
      Recipe(
          date: "2023-05-01",
          name: "Spinach omelette",
          probes: [
            Probe(name: "Chicken eggs used?", probeOptions: [
              ProbeOption(option: "Yes", id: "1"),
              ProbeOption(option: "No", id: "2")
            ])
          ],
          employeeNumber: "FP361",
          fctId: "ifct2017",
          surveyId: "TEST1",
          ingredients: [
            Ingredient(
                description: "Whole egg omelette",
                fctFoodItemId: "M007",
                fctFoodItemName: "Egg, poultry, omlet",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "100",
                  )
                ]),
            Ingredient(
                description: "Spinach leaves",
                fctFoodItemId: "C033",
                fctFoodItemName: "Spinach",
                cookingState: "Raw",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "20",
                  )
                ])
          ],
          measurements: [
            Measurement(
              id: const Uuid().v4(),
              method: "Direct weight",
              unit: "Grams",
              value: "120",
            )
          ],
          number: const Uuid().v4(),
          saved: true,
          type: "Standard Recipe"),
      Recipe(
          date: "2023-05-01",
          name: "Chicken curry with rice",
          probes: [
            Probe(name: "Chicken breast used?", probeOptions: [
              ProbeOption(option: "Yes", id: "1"),
              ProbeOption(option: "No", id: "2")
            ]),
            Probe(name: "White rice?", probeOptions: [
              ProbeOption(option: "Yes", id: "1"),
              ProbeOption(option: "No", id: "2")
            ])
          ],
          employeeNumber: "FP361",
          fctId: "ifct2017",
          surveyId: "TEST1",
          ingredients: [
            Ingredient(
                description: "Fried chicken breast",
                fctFoodItemId: "N003",
                fctFoodItemName: "Chicken, poultry, breast, skinless",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "200",
                  )
                ]),
            Ingredient(
                description: "Fried onion",
                fctFoodItemId: "G017",
                fctFoodItemName: "Onion, big",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "75",
                  )
                ]),
            Ingredient(
                description: "Fried tomato",
                fctFoodItemId: "D076",
                fctFoodItemName: "Tomato, ripe, local",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "400",
                  )
                ]),
            Ingredient(
                description: "Boiled white rice",
                fctFoodItemId: "A015",
                fctFoodItemName: "Rice, raw, milled",
                cookingState: "Boiled",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "400",
                  )
                ])
          ],
          measurements: [
            Measurement(
              id: const Uuid().v4(),
              method: "Direct weight",
              unit: "Grams",
              value: "1075",
            )
          ],
          number: const Uuid().v4(),
          saved: true,
          type: "Standard Recipe"),
      Recipe(
          date: "2023-05-01",
          name: "Saag aloo",
          probes: [
            Probe(name: "Onion added?", probeOptions: [
              ProbeOption(option: "Yes", id: "1"),
              ProbeOption(option: "No", id: "2")
            ])
          ],
          employeeNumber: "FP361",
          fctId: "ifct2017",
          surveyId: "TEST1",
          ingredients: [
            Ingredient(
                description: "Fried potato",
                fctFoodItemId: "F006",
                fctFoodItemName: "Potato, brown skin, big",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "500",
                  )
                ]),
            Ingredient(
                description: "Fried onion",
                fctFoodItemId: "G017",
                fctFoodItemName: "Onion, big",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "75",
                  )
                ]),
            Ingredient(
                description: "Fried spinach leaves",
                fctFoodItemId: "C033",
                fctFoodItemName: "Spinach",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "250",
                  )
                ]),
            Ingredient(
                description: "Cooked in sunflower oil",
                fctFoodItemId: "T012",
                fctFoodItemName: "Sunflower oil",
                cookingState: "Raw",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "15",
                  )
                ])
          ],
          measurements: [
            Measurement(
              id: const Uuid().v4(),
              method: "Direct weight",
              unit: "Grams",
              value: "840",
            )
          ],
          number: const Uuid().v4(),
          saved: true,
          type: "Standard Recipe"),
      Recipe(
          date: "2023-05-01",
          name: "Spaghetti bolognese",
          probes: [
            Probe(name: "Beef mince used?", probeOptions: [
              ProbeOption(option: "Yes", id: "1"),
              ProbeOption(option: "No", id: "2")
            ])
          ],
          employeeNumber: "FP361",
          fctId: "ifct2017",
          surveyId: "TEST1",
          ingredients: [
            Ingredient(
                description: "Minced",
                fctFoodItemId: "O025",
                fctFoodItemName: "Beef, shoulder",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "500",
                  )
                ]),
            Ingredient(
                description: "Fried onion",
                fctFoodItemId: "G017",
                fctFoodItemName: "Onion, big",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "150",
                  )
                ]),
            Ingredient(
                description: "Tomato for sauce",
                fctFoodItemId: "D076",
                fctFoodItemName: "Tomato, ripe, local",
                cookingState: "Fried",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "800",
                  )
                ]),
            Ingredient(
                description: "Dry spaghetti",
                fctFoodItemId: "A022",
                fctFoodItemName: "Wheat, semolina",
                cookingState: "Boiled",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "400",
                  )
                ]),
            Ingredient(
                description: "Cooked in sunflower oil",
                fctFoodItemId: "T012",
                fctFoodItemName: "Sunflower oil",
                cookingState: "Raw",
                id: const Uuid().v4(),
                saved: true,
                measurements: [
                  Measurement(
                    id: const Uuid().v4(),
                    method: "Direct weight",
                    unit: "Grams",
                    value: "10",
                  )
                ])
          ],
          measurements: [
            Measurement(
              id: const Uuid().v4(),
              method: "Direct weight",
              unit: "Grams",
              value: "1860",
            )
          ],
          number: const Uuid().v4(),
          saved: true,
          type: "Standard Recipe")
    ];

List<Survey> Function() sampleSurveys = () => [
      Survey(
          surveyId: "TEST1",
          fctId: "ifct2017",
          name: "Test survey",
          description: "Cambridge 18-30 MF",
          comments: "Testing purposes only",
          country: "United Kingdom",
          geoArea: "52.204381,0.125866,4858,11.6",
          requiredSex: null,
          minAge: 18,
          maxAge: 30),
    ];

final respondent1Id = const Uuid().v4();
final collection1Id = const Uuid().v4();
final respondent2Id = const Uuid().v4();
final collection2Id = const Uuid().v4();
final respondent3Id = const Uuid().v4();
final collection3Id = const Uuid().v4();
final respondent4Id = const Uuid().v4();
final collection4Id = const Uuid().v4();
final respondent5Id = const Uuid().v4();
final collection5Id = const Uuid().v4();
final respondent6Id = const Uuid().v4();
final collection6Id = const Uuid().v4();

List<Household> Function() sampleHouseholds = () => [
      Household(
          householdId: "HH42A2022001",
          sensitizationDate: DateTime(2023, 2, 1),
          geoLocation: "52.2125,0.1029",
          comments: "My household",
          respondents: {
            respondent1Id: Respondent(
                id: respondent1Id,
                name: "Faizaan Pervaiz",
                phoneNumber: "+447000123456",
                dateOfBirth: DateTime(2000, 1, 1),
                sex: Sex.male,
                literacyLevel: LiteracyLevel.readWrite,
                occupation: Occupation.student,
                comments: "Myself",
                collections: {
                  collection1Id: GibsonsForm(
                      id: collection1Id,
                      physioStatus: PhysioStatus.notApplicable,
                      finished: true,
                      comments: "First collection of this survey",
                      interviewDate: "2023-02-03",
                      interviewEndTime: "15:05",
                      interviewStartTime: "14:15",
                      interviewFinishedInOneVisit: "Yes",
                      interviewOutcome: "Completed",
                      pictureChartCollected: "Yes",
                      recallDay: "Normal",
                      surveyId: "TEST1",
                      foodItems: [
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "200",
                              )
                            ],
                            name: "Roast chicken",
                            preparationMethod: "Roasted with oil",
                            recipe: sampleRecipes()[0],
                            source: "Home",
                            timePeriod: "Afternoon (12:01 pm - 4:00 pm)"),
                      ],
                      metadata: Metadata.create(createdBy: "FP361")
                          .modify(lastModifiedBy: "FP361")),
                  collection2Id: GibsonsForm(
                      id: collection2Id,
                      physioStatus: PhysioStatus.notApplicable,
                      finished: false,
                      comments: "Second collection of this survey",
                      interviewDate: "2023-05-03",
                      interviewEndTime: "15:05",
                      interviewStartTime: "14:15",
                      interviewFinishedInOneVisit: "Yes",
                      interviewOutcome: "Completed",
                      pictureChartCollected: "Yes",
                      recallDay: "Normal",
                      surveyId: "TEST1",
                      foodItems: [
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "200",
                              )
                            ],
                            name: "Spaghetti bolognese",
                            preparationMethod: "Fried",
                            recipe: sampleRecipes()[4],
                            source: "Home",
                            timePeriod: "Afternoon (12:01 pm - 4:00 pm)"),
                      ],
                      metadata: Metadata.create(createdBy: "FP361")
                          .modify(lastModifiedBy: "FP361"))
                },
                anthropometrics: [
                  Anthropometrics(
                      date: DateTime(2023, 2, 1), height: 100, weight: 100)
                ],
                metadata: Metadata.create(createdBy: "FP361")
                    .modify(lastModifiedBy: "FP361"))
          },
          metadata: Metadata.create(createdBy: "FP361")
              .modify(lastModifiedBy: "FP361")),
      Household(
          householdId: "HH99X2022001",
          sensitizationDate: DateTime(2023, 1, 28),
          geoLocation: "52.204381,0.125866",
          comments: "Another household",
          respondents: {
            respondent2Id: Respondent(
                id: respondent2Id,
                name: "John Doe",
                phoneNumber: "+447000654321",
                dateOfBirth: DateTime(2000, 1, 15),
                sex: Sex.male,
                literacyLevel: LiteracyLevel.readWrite,
                occupation: Occupation.student,
                comments: "A male respondent",
                collections: {
                  collection3Id: GibsonsForm(
                      id: collection3Id,
                      physioStatus: PhysioStatus.notApplicable,
                      finished: true,
                      comments: "First collection of this survey",
                      interviewDate: "2023-02-03",
                      interviewEndTime: "15:30",
                      interviewStartTime: "16:00",
                      interviewFinishedInOneVisit: "Yes",
                      interviewOutcome: "Completed",
                      pictureChartCollected: "Yes",
                      recallDay: "Normal",
                      surveyId: "TEST1",
                      foodItems: [
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "120",
                              )
                            ],
                            name: "Spinach omelette",
                            preparationMethod: "Fried",
                            recipe: sampleRecipes()[1],
                            source: "Home",
                            timePeriod: "Morning (3:01 am - 12:00 pm)"),
                      ],
                      metadata: Metadata.create(createdBy: "FP361")
                          .modify(lastModifiedBy: "FP361")),
                  collection4Id: GibsonsForm(
                      id: collection4Id,
                      physioStatus: PhysioStatus.notApplicable,
                      finished: false,
                      comments: "Second collection of this survey",
                      interviewDate: "2023-02-03",
                      interviewEndTime: "15:30",
                      interviewStartTime: "16:00",
                      interviewFinishedInOneVisit: "Yes",
                      interviewOutcome: "Completed",
                      pictureChartCollected: "Yes",
                      recallDay: "Normal",
                      surveyId: "TEST1",
                      foodItems: [
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "120",
                              )
                            ],
                            name: "Spinach omelette",
                            preparationMethod: "Fried",
                            recipe: sampleRecipes()[1],
                            source: "Home",
                            timePeriod: "Morning (3:01 am - 12:00 pm)"),
                      ],
                      metadata: Metadata.create(createdBy: "FP361")
                          .modify(lastModifiedBy: "FP361"))
                },
                anthropometrics: [
                  Anthropometrics(
                      date: DateTime(2023, 5, 1), height: 100, weight: 100)
                ],
                metadata: Metadata.create(createdBy: "FP361")
                    .modify(lastModifiedBy: "FP361")),
            respondent3Id: Respondent(
                id: respondent3Id,
                name: "Lisa Jane",
                phoneNumber: "+447000987654",
                dateOfBirth: DateTime(1999, 11, 4),
                sex: Sex.female,
                literacyLevel: LiteracyLevel.readWrite,
                occupation: Occupation.student,
                comments: "A female respondent",
                collections: {
                  collection5Id: GibsonsForm(
                      id: collection5Id,
                      physioStatus: PhysioStatus.notApplicable,
                      finished: true,
                      comments: "First collection of this survey",
                      interviewDate: "2023-05-03",
                      interviewEndTime: "16:05",
                      interviewStartTime: "16:30",
                      interviewFinishedInOneVisit: "Yes",
                      interviewOutcome: "Completed",
                      pictureChartCollected: "Yes",
                      recallDay: "Normal",
                      surveyId: "TEST1",
                      foodItems: [
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "120",
                              )
                            ],
                            name: "Spinach omelette",
                            preparationMethod: "Fried",
                            recipe: sampleRecipes()[1],
                            source: "Home",
                            timePeriod: "Morning (3:01 am - 12:00 pm)"),
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "200",
                              )
                            ],
                            name: "Roast chicken",
                            preparationMethod: "Roasted with oil",
                            recipe: sampleRecipes()[0],
                            source: "Home",
                            timePeriod: "Afternoon (12:01 pm - 4:00 pm)"),
                      ],
                      metadata: Metadata.create(createdBy: "FP361")
                          .modify(lastModifiedBy: "FP361")),
                  collection6Id: GibsonsForm(
                      id: collection6Id,
                      physioStatus: PhysioStatus.notApplicable,
                      finished: false,
                      comments: "Second collection of this survey",
                      interviewDate: "2023-05-03",
                      interviewEndTime: "16:05",
                      interviewStartTime: "16:30",
                      interviewFinishedInOneVisit: "Yes",
                      interviewOutcome: "Completed",
                      pictureChartCollected: "Yes",
                      recallDay: "Normal",
                      surveyId: "TEST1",
                      foodItems: [
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "120",
                              )
                            ],
                            name: "Spinach omelette",
                            preparationMethod: "Fried",
                            recipe: sampleRecipes()[1],
                            source: "Home",
                            timePeriod: "Morning (3:01 am - 12:00 pm)"),
                        FoodItem(
                            confirmed: true,
                            id: const Uuid().v4(),
                            measurements: [
                              Measurement(
                                id: const Uuid().v4(),
                                method: "Direct weight",
                                unit: "Grams",
                                value: "200",
                              )
                            ],
                            name: "Roast chicken",
                            preparationMethod: "Roasted with oil",
                            recipe: sampleRecipes()[0],
                            source: "Home",
                            timePeriod: "Afternoon (12:01 pm - 4:00 pm)"),
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
          metadata: Metadata.create(createdBy: "FP361")
              .modify(lastModifiedBy: "FP361")),
    ];

void overwriteWithSampleData(
    HiveRepository hiveRepository, GibsonifyRepository gibsonifyRepository) {
  if (kDebugMode) {
    for (final household in hiveRepository.readHouseholds()) {
      hiveRepository.deleteHousehold(household.householdId);
    }

    for (final household in sampleHouseholds()) {
      hiveRepository.saveNewHousehold(household);
    }

    for (final survey in hiveRepository.readSurveys()) {
      hiveRepository.deleteSurvey(survey.surveyId);
    }

    for (final survey in sampleSurveys()) {
      hiveRepository.saveSurvey(survey);
    }

    gibsonifyRepository.saveRecipes(sampleRecipes());
  }
}
