import 'package:flutter_uikit/model/food_item.dart';
import 'package:flutter_uikit/model/consumption_data.dart';




class FormStrings{
  static const Map<TimeOfDaySelection,String> timeOfDaySelection = {
    TimeOfDaySelection.MORNING:    "Morning (4.00am - 12.00pm)",
    TimeOfDaySelection.AFTERNOON:  "Afternoon (12.01pm - 4.00pm)",
    TimeOfDaySelection.EVENING:    "Evening (4.01pm - 7.00pm)",
    TimeOfDaySelection.NIGHT:      "Night (7.01pm - 3.00am)",
  };

  static const Map<InterviewOutcomeSelection, String> interviewOutcomeSelection = {
    InterviewOutcomeSelection.COMPLETED:         "Completed",
    InterviewOutcomeSelection.INCOMPLETE:        "Incomplete",
    InterviewOutcomeSelection.ABSENT:            "Absent",
    InterviewOutcomeSelection.REFUSED:           "Refused",
    InterviewOutcomeSelection.COULD_NOT_LOCATE:  "Could Not Locate",
  };

  static const Map<SourceOfFoodSelection, String> sourceOfFoodOutcomeSelection = {
    SourceOfFoodSelection.HOMEMADE:       "Homemade",
    SourceOfFoodSelection.PURCHASED:      "Purchased",
    SourceOfFoodSelection.GIFT:           "Gift / Given by Neighbour",
    SourceOfFoodSelection.FARM:           "Home Garden / Farm",
    SourceOfFoodSelection.LEFTOVER:       "Leftovers",
    SourceOfFoodSelection.WILDFOOD:       "Wild Food",
    SourceOfFoodSelection.FOODAID:        "Food Aid",
    SourceOfFoodSelection.OTHER:          "Other",
    SourceOfFoodSelection.NA:             "NA",
  };

  static const Map<FormWhenEatenSelection,String> formWhenEatenSelection = {
    FormWhenEatenSelection.RAW:                     "Raw",
    FormWhenEatenSelection.BOILED:                  "Boiled",
    FormWhenEatenSelection.BOILED_RETAINED_WATER:   "Boiled in water but retained water",
    FormWhenEatenSelection.BOILED_REMOVED_WATER:    "Boiled in water but removed water",
    FormWhenEatenSelection.STEAMED:                 "Steamed",
    FormWhenEatenSelection.ROAST_WITH_OIL:          "Roasted with Oil",
  };

}

String emptyFieldValidator(String answer){
  if (answer.isEmpty){
    return "Please fill in this field!";
  }
  return null;
}