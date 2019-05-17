import 'package:flutter/material.dart';


class FoodItem {
  DateTime timeOfDay;
  String foodName;
  String foodDescription;
  String formWhenEaten;
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
