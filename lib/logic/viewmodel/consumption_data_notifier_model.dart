import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_uikit/model/consumption_data.dart';


class ConsumptionDataProvider with ChangeNotifier {
  List<ConsumptionData> _dataList;

  List<ConsumptionData> get dataList => _dataList;

  set dataList(List<ConsumptionData> value) {
    _dataList = dataList;
    notifyListeners();
  }

  void add(item) {
    _dataList.add(item);
    notifyListeners();
  }
}