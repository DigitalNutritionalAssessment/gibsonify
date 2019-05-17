import 'dart:async';
import 'package:flutter_uikit/model/consumption_data.dart';

class ConsumptionDataListBloc{

  List<ConsumptionData> _consumptionDataList;

  // Stream to handle consumptionDataList
  final StreamController<List<ConsumptionData>> _consumptionDataListController = StreamController<List<ConsumptionData>>();
  Stream<List<ConsumptionData>> get outConsumptionDataList => _consumptionDataListController.stream;

//  // Stream to handle data in
//  StreamController<ConsumptionData> _consumptionDataController = StreamController<ConsumptionData>();
//  StreamSink<ConsumptionData> get _inConsumptionData => _consumptionDataController.sink;


  //
  // Constructor
  //
  ConsumptionDataListBloc(){
    _consumptionDataList = [];
  }

  void updateConsumptionDataItem(ConsumptionData item, int index){

    if (index == _consumptionDataList.length){
      _consumptionDataList.add(item);
    }
    else if (index > _consumptionDataList.length){
      print("Error!");
    }
    else{
      _consumptionDataList[index] = item;
    }

    _consumptionDataListController.add(_consumptionDataList);
  }

  void dispose(){
    _consumptionDataListController.close();
//    _consumptionDataController.close();
  }
}
