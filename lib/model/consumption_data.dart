import 'dart:async';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/food_item.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_uikit/model/consumption_data_db.dart';



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
    if (this.listOfFoods == null) this.listOfFoods = List<FoodItem>();
  }

  static String generateFileName(ConsumptionData consumptionData){
    return consumptionData.id + "_" + consumptionData.interviewData.respondent.name + "_" +
        consumptionData.interviewData.interviewStart.day.toString() +
        consumptionData.interviewData.interviewStart.month.toString() +
        consumptionData.interviewData.interviewStart.year.toString() +
        ".txt";
  }

  static String getIdFromFileName(String filename){
    String baseName = basename(filename);
    if (baseName.contains(".txt")){
      List<String> tokens = baseName.split("_");
      return (tokens.length == 3)? tokens[0] : null;
    }else return null;

  }
//
//  ConsumptionData.fromFileName(String filename){
//    String baseName = basename(filename);
//    print(baseName);
//    List<String> tokens = baseName.split("_");
//    if (tokens == 3){
//      id = tokens[0];
//    }
//    else id=null;
//  }


  void save(){
    print("Saving...");
    LocalItemStorage localItemStorage = LocalItemStorage( fileName: generateFileName(this));
    localItemStorage.writeConsumptionData(this);
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
  String id;
  String employeeNumber;

  Person({
    this.name,
    this.telephone,
    this.id,
    this.employeeNumber,
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'telephone': telephone,
        'employeeNumber': employeeNumber,
      };

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        telephone = json['telephone'],
        employeeNumber = json['employeeNumber'];

}

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

class InterviewData{
  String householdIdentification;
  Person respondent;
  DateTime sensitizationVisitDate;
  DayCode dayCode;
  DateTime interviewStart;
  DateTime interviewEnd;
  bool secondInterview;
  DateTime secondInterviewDate;
  String secondInterviewReason;
  InterviewOutcomeSelection interviewOutcome;
  String incompleteInterviewReason;

  InterviewData({this.householdIdentification, this.respondent,
      this.sensitizationVisitDate, this.dayCode, this.interviewStart,
      this.interviewEnd, this.secondInterview, this.secondInterviewDate,
      this.secondInterviewReason,
      this.interviewOutcome, this.incompleteInterviewReason}) {
    if (this.respondent == null) this.respondent = Person();
  }


  Map<String, dynamic> toJson() =>
      {
        'householdIdentification': householdIdentification,
        'respondent': respondent,
        'sensitizationVisitDate': sensitizationVisitDate.toString(),
        'dayCode': dayCode?.index,
        'interviewStart': interviewStart.toString(),
        'interviewEnd':interviewEnd.toString(),
        'interviewOutcome':interviewOutcome?.index,
        'incompleteInterviewReason': incompleteInterviewReason,
      };

  InterviewData.fromJson(Map<String, dynamic> json)
      : householdIdentification = json['householdIdentification'],
        respondent = Person.fromJson(json['respondent']),
        sensitizationVisitDate = DateTime.tryParse(json['sensitizationVisitDate']),
//        dayCode = DayCode.values[json['dayCode']],
        interviewStart = DateTime.tryParse(json['interviewStart']),
        interviewEnd = DateTime.tryParse(json['interviewEnd']),
        interviewOutcome = InterviewOutcomeSelection.values[json['interviewOutcome']],
        incompleteInterviewReason = json['incompleteInterviewReason']??null;
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
    return context.inheritFromWidgetOfExactType(ConsumptionDataInheritedWidget);
  }
}