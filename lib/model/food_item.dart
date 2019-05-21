import 'package:flutter/material.dart';


class FoodItem {
  TimeOfDaySelection timeOfDay;
  String foodName;
  SourceOfFoodSelection foodSource;
  String foodDescription;
  FormWhenEatenSelection formWhenEaten;
  String measurementMethod;
  double measurement;
  String measurementUnits;

  FoodItem(
      {this.timeOfDay,
      this.foodName,
      this.foodDescription,
      this.formWhenEaten,
      this.measurementMethod,
      this.measurement,
      this.measurementUnits
      }
  );

  Map<String, dynamic> toJson() =>
      {
        'foodName': foodName,
        'timeOfDay': timeOfDay?.index,
        'foodDescription':foodDescription,
        'formWhenEaten':formWhenEaten?.index,
        'foodSource': foodSource?.index,
      };


  FoodItem.fromJson(Map<String, dynamic> json)
      : foodName = json['foodName'],
        timeOfDay = TimeOfDaySelection.values[json['timeOfDay']],
        foodDescription = json['foodDescription'],
        formWhenEaten = FormWhenEatenSelection.values[json['formWhenEaten']],
        foodSource = SourceOfFoodSelection.values[json['foodSource']];
}

class FoodItemsList {
  final List<FoodItem> listOfFoods;

  FoodItemsList({
    this.listOfFoods,
  });

  factory FoodItemsList.fromJson(List<dynamic> json){
    List<FoodItem> a = [];
    for (var i in json){
      a.add(FoodItem.fromJson(i));
      print(FoodItem.fromJson(i));
    }

    return new FoodItemsList(
        listOfFoods :json.map((i)=>FoodItem.fromJson(i)).toList(),
    );
  }
}

enum TimeOfDaySelection{
  MORNING,
  AFTERNOON,
  EVENING,
  NIGHT,
}

enum SourceOfFoodSelection{
  HOMEMADE,
  PURCHASED,
  GIFT,
  FARM,
  LEFTOVER,
  WILDFOOD,
  FOODAID,
  OTHER,
  NA,
}

enum FormWhenEatenSelection{
  RAW,
  BOILED,
  BOILED_RETAINED_WATER,
  BOILED_REMOVED_WATER,
  STEAMED,
  ROAST_WITH_OIL,
}


// Inherited widget for managing a ConsumptionData Item
class FoodItemInheritedWidget extends InheritedWidget {
  const FoodItemInheritedWidget({
    Key key,
    this.itemData,
    Widget child}) : super(key: key, child: child);

  final FoodItem itemData;

  @override
  bool updateShouldNotify(FoodItemInheritedWidget old) {
    print('In updateShouldNotify');
    return itemData != old.itemData;
  }

  static FoodItemInheritedWidget of(BuildContext context) {
    // You could also just directly return the name here
    // as there's only one field
    return context.inheritFromWidgetOfExactType(FoodItemInheritedWidget);
  }
}

