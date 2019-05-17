import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/ui/page/new_collection/collection_page_common_widgets.dart';
import 'package:flutter_uikit/model/consumption_data.dart';

// Inherited widget for managing a ConsumptionData Item
class ConsumptionDataInheritedWidget extends InheritedWidget {
  const ConsumptionDataInheritedWidget({
    Key key,
    this.itemData,
    Widget child}) : super(key: key, child: child);

  final ConsumptionData itemData;

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

// Stateful widget for managing a consumption data item
class ConsumptionDataItem extends StatefulWidget {

  final ConsumptionData inputItemData;

  const ConsumptionDataItem({
    @required this.inputItemData,
  });

  @override
  _ConsumptionDataItemState createState() => new _ConsumptionDataItemState();
}

// State for managing a consumption data item
class _ConsumptionDataItemState extends State<ConsumptionDataItem> {

  ConsumptionData itemData;

  @override
  void initState() {
    super.initState();
    if (widget.inputItemData == null) itemData = ConsumptionData(timeOfDay: DateTime.now());
    else itemData = widget.inputItemData;
  }

  @override
  Widget build(BuildContext context) {
    return new ConsumptionDataInheritedWidget(
        itemData: itemData,
        child: const FoodItemCard(),
    );
  }
}

class CollectionFirstPage extends StatefulWidget {
  @override
  _CollectionFirstPageState createState() => _CollectionFirstPageState();
}

class _CollectionFirstPageState extends State<CollectionFirstPage> {

  List<ConsumptionData> dataList = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: appBar(title: "Collecting New Data", bottomBarTitle: "First Pass"),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                itemCount: dataList?.length ?? 0,
                itemBuilder: (BuildContext ctx, int index) {
                  return new ConsumptionDataItem(inputItemData: dataList[index]);
                },
              ),
            ),
            new FittedBox(
              fit: BoxFit.contain,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: const Text('Add new Food'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      dataList.add(ConsumptionData());
                      setState(() {});
                      // Perform some action
                    },
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}


class FoodItemCard extends StatelessWidget {
  const FoodItemCard();

  static const double edgeInset = 9.0;

  @override
  Widget build(BuildContext context) {

    final inheritedWidget = ConsumptionDataInheritedWidget.of(context);
    
    return Card(
      elevation: 2.0,
      child: Container(
//      height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all (edgeInset),
              child: Question(
                  questionText: "What did you eat this morning?",
                  hint:"Input food here",
                  onSubmitted: (answer) => {inheritedWidget.itemData.foodName = answer},
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(edgeInset),
              child: TimePicker(
                onChanged: (time) {inheritedWidget.itemData.timeOfDay = time;},
                onConfirm: (time) {inheritedWidget.itemData.timeOfDay = time;},
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}










