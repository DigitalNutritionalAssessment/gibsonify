import 'package:flutter/material.dart';


class FoodItem {
  TimeOfDaySelection timeOfDay;
  String foodName;
  SourceOfFoodSelection foodSource;
  List<IngredientItem> ingredientItems;
  Recipe recipe;


  FoodItem({
    this.timeOfDay,
    this.foodName,
    this.foodSource,
    this.ingredientItems,
    this.recipe,
  }){
    if (this.ingredientItems == null) this.ingredientItems = [];
    if (this.recipe == null) this.recipe = Recipe();
  }

  Map<String, dynamic> toJson() =>
      {
        'foodName': foodName,
        'timeOfDay': timeOfDay?.index,
        'foodSource': foodSource?.index,
        'recipe':recipe,
        'ingredients':ingredientItems,
      };


  FoodItem.fromJson(Map<String, dynamic> json)
      : foodName = json['foodName'],
        timeOfDay = (json['timeOfDay'] != null) ? TimeOfDaySelection.values.elementAt(json['timeOfDay']): null,
        foodSource = (json['foodSource'] != null) ? SourceOfFoodSelection.values.elementAt(json['foodSource']): null,
        ingredientItems = IngredientsItemsList.fromJson(json['ingredients'] as List).ingredientItems,
        recipe = Recipe.fromJson(json['recipe']);
}


class IngredientItem{
  String foodItemName;
  String foodGroup;
  int fctCode;
  int rCode;
  FormWhenEatenSelection formWhenEaten;
  MeasurementUnitSelection measurementUnit;    //MeasurementUnits
  MeasurementMethodSelection measurementMethod;
  double measurement;

  IngredientItem({this.foodItemName, this.foodGroup, this.fctCode, this.rCode,
      this.formWhenEaten, this.measurementUnit, this.measurement, this.measurementMethod});

  Map<String, dynamic> toJson() =>
      {
        'foodItemName':foodItemName,
        'foodGroup':foodGroup,
        'formWhenEaten':formWhenEaten?.index,
        'fctCode': fctCode,
        'rCode': rCode,
        'measurementUnit':measurementUnit?.index,
        'measurement':measurement,
        'measurementMethod':measurementMethod,
      };

  IngredientItem.fromJson(Map<String, dynamic> json)
      : foodItemName = json['foodItemName'],
        foodGroup = json['foodGroup'],
        formWhenEaten = (json['formWhenEaten'] != null) ? FormWhenEatenSelection.values.elementAt(json['formWhenEaten']): null,
        fctCode = json['fctCode'],
        rCode = json['rCode'],
        measurementUnit = (json['measurementUnit'] != null) ? MeasurementUnitSelection.values.elementAt(json['measurementUnit']): null,
        measurement = json['measurement'],
        measurementMethod = (json['measurementMethod'] != null) ? MeasurementMethodSelection.values.elementAt(json['measurementMethod']): null;

}

class Recipe{
  int id;
  String description;
  RecipeType recipeType;

  Recipe({this.id, this.description, this.recipeType});

  Recipe.fromJson(Map<String, dynamic> json){
    id = json['id'];
    description = json['description'];
    recipeType = (json['recipeType'] != null) ? RecipeType.values.elementAt(json['recipeType']) : null;
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'description': description,
        'recipeType': recipeType?.index,
      };

}


/////////////// Helper List classes for JSON encoding / decoding ///////////////

class FoodItemsList {

  final List<FoodItem> listOfFoods;

  FoodItemsList({
    this.listOfFoods,
  });

  factory FoodItemsList.fromJson(List<dynamic> json){
    return new FoodItemsList(
      listOfFoods :json.map((i)=>FoodItem.fromJson(i)).toList(),
    );
  }
}

class IngredientsItemsList {

  final List<IngredientItem> ingredientItems;

  IngredientsItemsList({
    this.ingredientItems,
  });

  factory IngredientsItemsList.fromJson(List<dynamic> json){
    return new IngredientsItemsList(
      ingredientItems :json.map((i)=>IngredientItem.fromJson(i)).toList(),
    );
  }
}

///////////////////////// ENUMS declared here ///////////////////////////////


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

enum MeasurementMethodSelection{
  DIRECT_WEIGHT,
  VOLUME_OF_WATER,
  VOLUME_OF_FOOD,
  PLAYDOUGH,
  NUMBER,
  PHOTOSIZE,
}

enum MeasurementUnitSelection{
  MILLILITRES,
  GRAMS,
}

enum RecipeType{
  STANDARD,
  MODIFIED
}
