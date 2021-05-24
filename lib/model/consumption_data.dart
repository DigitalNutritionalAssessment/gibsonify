import 'dart:async';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/food_item.dart';
//import 'package:flutter_uikit/model/recipes.dart';
import 'package:uuid/uuid.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter_uikit/model/consumption_data_db.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';




class ConsumptionData {
  String id;
  InterviewData interviewData;
  List<FoodItem> listOfFoods;
  String filename;

  ConsumptionData({
    this.id,
    this.interviewData,
    this.listOfFoods,
    this.filename,
  }){
    var uuid = Uuid();
    if (this.id == null) this.id = uuid.v1();
    if (this.interviewData == null) this.interviewData = InterviewData();
    // ignore: deprecated_member_use
    if (this.listOfFoods == null) this.listOfFoods = List<FoodItem>(); //quickfix of list
  }

  static String generateFileName(ConsumptionData consumptionData){

    // To do: update dates based on either interviewStart or sensitisation visit date, whichever is later.
    // For simplicity for now, we use only the sensitisation visit date, because that is guaranteed to exist.
    return consumptionData.id + "_" + consumptionData.interviewData.respondent.name + "_" +
        consumptionData.interviewData.sensitizationVisitDate.day.toString() +
        consumptionData.interviewData.sensitizationVisitDate.month.toString() +
        consumptionData.interviewData.sensitizationVisitDate.year.toString() +
        ".json";
  }

  static String getIdFromFileName(String filename){
    String baseName = basename(filename);
    if (baseName.contains(".json")){
      List<String> tokens = baseName.split("_");
      return (tokens.length == 3)? tokens[0] : null;
    }else return null;

  }

  void save(){
    print("Saving...");
    LocalItemStorage localItemStorage = LocalItemStorage( fileName: generateFileName(this));
    localItemStorage.writeConsumptionData(this);
    
    for (FoodItem foodItem in this.listOfFoods){
      IcrisatDB().updateRecipes(foodItem);
    }
  }

  Future<ConsumptionData> load(filename) async {
    LocalItemStorage localItemStorage = LocalItemStorage(fileName: filename);
    ConsumptionData consumptionData = await localItemStorage.readConsumptionData();
    if (consumptionData == null) return null;
    this.id = consumptionData.id;
    this.interviewData = consumptionData.interviewData;
    this.listOfFoods = consumptionData.listOfFoods;
    this.filename = localItemStorage.fileName;

    return this;
  }

  ConsumptionData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        listOfFoods = FoodItemsList.fromJson(json['listOfFoods'] as List).listOfFoods,
        interviewData = InterviewData.fromJson(json['interviewData']);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'interviewData': interviewData,
        'listOfFoods': listOfFoods,
      };

  Map<String, dynamic> toCondensedDBMap() =>
      {
        'id': id,
        'name': interviewData.respondent.name,
      };

}

class Person{
  String name;
  String telephone;
  int id;
  int employeeNumber;
  DateTime birthDate;

  Person({
    this.name,
    this.telephone,
    this.id,
    this.employeeNumber,
    this.birthDate,
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'telephone': telephone,
        'employeeNumber': employeeNumber,
        'birthDate':birthDate?.toString(),
      };

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        telephone = json['telephone'],
        employeeNumber = json['employeeNumber'],
        birthDate = DateTime.tryParse(json['birthDate']??"");


  static Future<Person> getEnumeratorFromSharedPrefs() async {

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Person enumerator =  Person();
    enumerator.name = _prefs.getString("userName");
    enumerator.employeeNumber = _prefs.getInt("employeeNumber");

    return enumerator;
  }

}

class InterviewData{
  String householdIdentification;
  Person respondent;
  Person enumerator;
  DateTime sensitizationVisitDate;
  DayCode dayCode;
  DateTime interviewStart;
  DateTime interviewEnd;
  DateTime recallDate;
  bool secondInterview;
  DateTime secondInterviewDate;
  String secondInterviewReason;
  InterviewOutcomeSelection interviewOutcome;
  String incompleteInterviewReason;
  LocData location;

  InterviewData({this.householdIdentification, this.respondent, this.enumerator,
      this.sensitizationVisitDate, this.dayCode, this.interviewStart,
      this.interviewEnd, this.secondInterview, this.secondInterviewDate,
      this.secondInterviewReason,
      this.interviewOutcome, this.incompleteInterviewReason, this.recallDate,
      this.location}) {
    if (this.respondent == null) this.respondent = Person();
    if (this.enumerator == null) this.enumerator = Person();
    if (this.location == null) this.location = LocData();
  }


  Map<String, dynamic> toJson() =>
      {
        'householdIdentification': householdIdentification,
        'respondent': respondent,
        'enumerator': enumerator,
        'sensitizationVisitDate': sensitizationVisitDate.toString(),
        'dayCode': (dayCode?.index != null) ? dayCode.index + 1 : null,
        'recallData': recallDate.toString(),
        'interviewStart': interviewStart.toString(),
        'interviewEnd':interviewEnd.toString(),
        'interviewOutcome':(interviewOutcome?.index != null) ? interviewOutcome.index + 1 : null,
        'incompleteInterviewReason': incompleteInterviewReason,
        'location':location,
      };

  InterviewData.fromJson(Map<String, dynamic> json)
      : householdIdentification = json['householdIdentification'],
        respondent = Person.fromJson(json['respondent']),
        enumerator = Person.fromJson(json['enumerator']),
        sensitizationVisitDate = DateTime.tryParse(json['sensitizationVisitDate']??""),
        dayCode = (json['dayCode'] != null) ? DayCode.values.elementAt(json['dayCode'] - 1):null,
        recallDate = DateTime.tryParse(json['recallDate']??""),
        interviewStart = DateTime.tryParse(json['interviewStart']??""),
        interviewEnd = DateTime.tryParse(json['interviewEnd']??""),
        interviewOutcome = (json['interviewOutcome'] != null) ? InterviewOutcomeSelection.values.elementAt(json['interviewOutcome'] - 1):null,
        incompleteInterviewReason = json['incompleteInterviewReason']??null,
        location = LocData.fromJson(json['location'] ?? Map<String,dynamic>());

  static Future<String> getLocationFromSharedPrefs() async {

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    
    return _prefs.get("location");
  }
  
}


class LocData{
  double latitude; // Latitude, in degrees
  double longitude; // Longitude, in degrees
  double accuracy;  // Estimated horizontal accuracy of this location, radial, in meters
  String locationName;

  LocData({this.latitude, this.longitude,
      this.accuracy, this.locationName});


  Map<String, dynamic> toJson() =>
      {
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy,
        'locationName': locationName,
      };

  LocData.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        accuracy = json['accuracy'],
        locationName = json['locationName'];

}


// Inherited widget for managing a ConsumptionData Item
class ConsumptionDataInheritedWidget extends InheritedWidget {
  const ConsumptionDataInheritedWidget({
    Key key,
    this.consumptionData,
    Widget child}) : super(key: key, child: child);

  final ConsumptionData consumptionData;

  @override
  bool updateShouldNotify(ConsumptionDataInheritedWidget old) {
    print('In updateShouldNotify');
    return consumptionData != old.consumptionData;
  }

  static ConsumptionDataInheritedWidget of(BuildContext context) {
    // You could also just directly return the name here
    // as there's only one field
    return context.dependOnInheritedWidgetOfExactType(aspect: ConsumptionDataInheritedWidget); //changed to depend On, added aspect
  }
}

///////////////////////// ENUMS declared here ///////////////////////////////

enum DayCode{
  NORMAL,
  SICK,
  FASTING,
  FESTIVAL,
  PARTIES,
  VISITORS,
  OTHERS,
}

enum InterviewOutcomeSelection{
  COMPLETED,
  INCOMPLETE,
  ABSENT,
  REFUSED,
  COULD_NOT_LOCATE,
}
