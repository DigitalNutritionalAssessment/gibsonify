import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:rxdart/rxdart.dart';


import 'package:flutter_uikit/ui/page/new_collection/collection_page_common_widgets.dart';
import 'package:flutter_uikit/model/food_item.dart';

// Inherited widget for managing a name
class ConsumptionDataInheritedWidget extends InheritedWidget {
  const ConsumptionDataInheritedWidget({
    Key key,
    this.itemData,
    Widget child}) : super(key: key, child: child);

  final FoodItem itemData;

  @override
  bool updateShouldNotify(ConsumptionDataInheritedWidget old) {
    print('In updateShouldNotify');
    return itemData != old.itemData;
  }

  static ConsumptionDataInheritedWidget of(BuildContext context) {
    // You could also just directly return the name here
    // as there's only one field
    return context.inheritFromWidgetOfExactType(ConsumptionDataInheritedWidget);
  }
}

// Stateful widget for managing name data
class CollectionInfoPage extends StatefulWidget {
  @override
  _CollectionInfoPageState createState() => new _CollectionInfoPageState();
}

// State for managing fetching name data over HTTP
class _CollectionInfoPageState extends State<CollectionInfoPage> {
  FoodItem itemData;

  @override
  void initState() {
    super.initState();
    itemData = FoodItem(timeOfDay: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return new ConsumptionDataInheritedWidget(
        itemData: itemData,
        child: const PageWidget()
    );
  }
}

class PageWidget extends StatelessWidget {
  const PageWidget();

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = ConsumptionDataInheritedWidget.of(context);
    return new Text(
      inheritedWidget.itemData.timeOfDay.toIso8601String(),
      style: UIData.smallTextStyle,
    );
  }
}





















