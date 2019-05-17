import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_uikit/model/food_item.dart';


class ConsumptionDataProvider with ChangeNotifier {
  List<FoodItem> _dataList;

  List<FoodItem> get dataList => _dataList;

  set dataList(List<FoodItem> value) {
    _dataList = dataList;
    notifyListeners();
  }

  void add(item) {
    _dataList.add(item);
    notifyListeners();
  }
}