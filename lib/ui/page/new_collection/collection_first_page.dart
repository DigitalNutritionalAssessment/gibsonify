import 'package:flutter/material.dart';

import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/ui/page/new_collection/collection_page_common_widgets.dart';
import 'package:flutter_uikit/model/food_item.dart';

class CollectionFirstPage extends StatefulWidget {
  @override
  _CollectionFirstPageState createState() => _CollectionFirstPageState();
}

class _CollectionFirstPageState extends State<CollectionFirstPage> {

  List<FoodItem> dataList = [];

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
                  return new FoodItemDataWidget(inputItemData: dataList[index]);
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
                      dataList.add(FoodItem());
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

// Stateful widget for managing a consumption data item
class FoodItemDataWidget extends StatefulWidget {

  final FoodItem inputItemData;

  const FoodItemDataWidget({
    @required this.inputItemData,
  });

  @override
  _FoodItemDataWidgetState createState() => new _FoodItemDataWidgetState();
}

// State for managing a consumption data item
class _FoodItemDataWidgetState extends State<FoodItemDataWidget> {

  FoodItem itemData;

  @override
  void initState() {
    super.initState();
    if (widget.inputItemData == null) itemData = FoodItem(timeOfDay: DateTime.now());
    else itemData = widget.inputItemData;
  }

  @override
  Widget build(BuildContext context) {
    return new FoodItemInheritedWidget(
      itemData: itemData,
      child: const FoodItemCard(),
    );
  }
}


class FoodItemCard extends StatelessWidget {
  const FoodItemCard();

  static const double edgeInset = 9.0;

  @override
  Widget build(BuildContext context) {

    final inheritedWidget = FoodItemInheritedWidget.of(context);
    
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










