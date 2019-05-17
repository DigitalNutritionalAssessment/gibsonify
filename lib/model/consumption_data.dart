import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/food_item.dart';

class ConsumptionData {
  Person subject;
  List<FoodItem> listOfFoods;


  ConsumptionData({
    this.subject,
    this.listOfFoods,
  });
}

class Person{
  String name;
  int age;
  bool gender;        // 0 -- Male, 1 -- Female

  Person({
    this.name,
    this.age,
    this.gender,
  });
}


// Inherited widget for managing a ConsumptionData Item
class ConsumptionDataInheritedWidget extends InheritedWidget {
  const ConsumptionDataInheritedWidget({
    Key key,
    this.listOfFoods,
    Widget child}) : super(key: key, child: child);

  final FoodItem listOfFoods;

  @override
  bool updateShouldNotify(ConsumptionDataInheritedWidget old) {
    print('In updateShouldNotify');
    return listOfFoods != old.listOfFoods;
  }

  static ConsumptionDataInheritedWidget of(BuildContext context) {
    // You could also just directly return the name here
    // as there's only one field
    return context.inheritFromWidgetOfExactType(ConsumptionDataInheritedWidget);
  }
}