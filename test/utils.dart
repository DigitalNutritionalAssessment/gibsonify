import 'package:gibsonify_api/gibsonify_api.dart';

Survey Function() mockSurvey = () =>
    Survey(surveyId: "S1", name: "Test", country: "GB", minAge: 0, maxAge: 100);

Household Function() mockHousehold = () => Household(
    householdId: "HH00A00000A",
    sensitizationDate: DateTime.now(),
    geoLocation: "51.5,-0.5",
    comments: "Test household",
    respondents: {
      "R1": Respondent(
          id: "R1",
          name: "Test Respondent",
          phoneNumber: "+447000123456",
          dateOfBirth: DateTime(2000, 1, 1),
          sex: Sex.male,
          literacyLevel: LiteracyLevel.readWrite,
          occupation: Occupation.casualLabour,
          comments: "Test respondent",
          collections: {
            "C1": GibsonsForm(
                id: "C1",
                physioStatus: PhysioStatus.notApplicable,
                finished: true,
                comments: "Test collection",
                interviewDate: "2020-01-01",
                interviewEndTime: "00:00",
                interviewStartTime: "00:00",
                interviewFinishedInOneVisit: "No",
                interviewOutcome: "Incomplete",
                interviewOutcomeNotCompletedReason: "Other",
                pictureChartCollected: "No",
                pictureChartNotCollectedReason: "Other",
                recallDay: "Normal",
                secondInterviewVisitDate: "2020-01-01",
                secondVisitReason: "Other",
                surveyId: "S1",
                foodItems: [
                  FoodItem(
                      confirmed: true,
                      customPreparationMethod: "Washed",
                      description: "Green beans",
                      id: "F1",
                      measurements: [
                        Measurement(
                            method: "Volume", unit: "Litre", value: "1.0")
                      ],
                      name: "Beans",
                      preparationMethod: "Other",
                      recipe: Recipe(
                          name: "Beans",
                          allProbeAnswersStandard: true,
                          allProbesChecked: true,
                          date: "2020-01-01",
                          employeeNumber: "TEST1",
                          ingredients: [
                            Ingredient(
                                cookingState: "A",
                                id: "B",
                                name: "C",
                                customCookingState: "D",
                                customName: "E",
                                description: "F",
                                measurements: [
                                  Measurement(
                                      method: "Volume",
                                      unit: "Litre",
                                      value: "1.0")
                                ],
                                saved: true)
                          ],
                          measurements: [
                            Measurement(
                                method: "Volume", unit: "Litre", value: "1.0")
                          ],
                          number: "5",
                          probes: [
                            Probe(
                                name: "Probe",
                                answer: "Yes",
                                checked: true,
                                probeOptions: [
                                  ProbeOption(option: "Yes", id: "1")
                                ])
                          ],
                          saved: true,
                          type: "Standard"),
                      source: "Home",
                      timePeriod: "Morning"),
                ],
                metadata: Metadata.create(createdBy: "TEST1")
                    .modify(lastModifiedBy: "TEST1"))
          },
          anthropometrics: [
            Anthropometrics(date: DateTime.now(), height: 100, weight: 100)
          ],
          metadata: Metadata.create(createdBy: "TEST1")
              .modify(lastModifiedBy: "TEST1"))
    },
    metadata:
        Metadata.create(createdBy: "TEST1").modify(lastModifiedBy: "TEST1"));