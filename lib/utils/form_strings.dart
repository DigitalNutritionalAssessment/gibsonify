import 'package:flutter_uikit/model/food_item.dart';
import 'package:flutter_uikit/model/consumption_data.dart';

class FormStrings{
  static const Map<TimeOfDaySelection,String> timeOfDaySelection = {
    TimeOfDaySelection.MORNING:    "Morning (4.00am - 12.00pm)",
    TimeOfDaySelection.AFTERNOON:  "Afternoon (12.01pm - 4.00pm)",
    TimeOfDaySelection.EVENING:    "Evening (4.01pm - 7.00pm)",
    TimeOfDaySelection.NIGHT:      "Night (7.01pm - 3.00am)",
    //TimeOfDaySelection.LATE:      "Testing", //If adding an additional try, then can add it afterwards, but need to change 
    //it to the corresponding files, e.g. for this it is food_item.dart
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

  static const Map<MeasurementUnitSelection,String> measurementUnitSelection = {
    MeasurementUnitSelection.MILLILITRES:    "ml",
    MeasurementUnitSelection.GRAMS:          "Grams Fraction",
    MeasurementUnitSelection.SMALL_SPOON:    "Small Spoon",
    MeasurementUnitSelection.BIG_SPOON:      "Big Spoon",
    MeasurementUnitSelection.STANDARD_CUP:   "Standard Cup",
    MeasurementUnitSelection.SMALL:          "Small",
    MeasurementUnitSelection.MEDIUM:         "Medium",
    MeasurementUnitSelection.LARGE:          "Large",
  };

  static const Map<RecipeType,String> recipeTypeSelection = {
    RecipeType.STANDARD:          "Standard",
    RecipeType.MODIFIED:          "Modified Standard",
  };

  static const Map<DayCode,String> dayCodeSelection = {
    DayCode.NORMAL:    "Normal",
    DayCode.SICK:      "Sick",
    DayCode.FASTING:   "Fasting",
    DayCode.FESTIVAL:  "Festival/religious day",
    DayCode.PARTIES:   "Parties/functions day",
    DayCode.VISITORS:  "Visitors (relatives)",
    DayCode.OTHERS:    "Others",
  };

  static const Map<MeasurementMethodSelection,String> measurementMethodSelection = {
    MeasurementMethodSelection.DIRECT_WEIGHT:          "Direct Weight",
    MeasurementMethodSelection.VOLUME_OF_WATER:        "Volume of Water",
    MeasurementMethodSelection.VOLUME_OF_FOOD:         "Volume of Food",
    MeasurementMethodSelection.PLAYDOUGH:              "Play Dough",
    MeasurementMethodSelection.NUMBER:                 "Number",
    MeasurementMethodSelection.PHOTOSIZE:              "Size (Picture)",
  };


}

String emptyFieldValidator(String answer){
  if (answer.isEmpty){
    return "Please fill in this field!";
  }
  return null;
}