import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/bloc/post_bloc.dart';
import 'package:flutter_uikit/model/post.dart';
import 'package:flutter_uikit/ui/widgets/common_divider.dart';
import 'package:flutter_uikit/ui/widgets/common_drawer.dart';
import 'package:flutter_uikit/ui/widgets/label_icon.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_uikit/ui/page/new_collection/collection_page_common_widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/model/food_item.dart';
import 'package:flutter_uikit/logic/viewmodel/consumption_data_notifier_model.dart';


Widget question({
    @required String questionText,
    @required String hint,
    @required controller,
}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
          questionText,
          style: UIData.smallTextStyle_Bold
      ),
      TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint
        ),
        style: UIData.smallTextStyle,
        //onChanged: onChanged,
      ),
    ],
  );
}

class NewCollectionPage extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<NewCollectionPage> {
  List<FoodItem> dataList = [];

  @override
  Widget build (BuildContext ctx) {
    return new Scaffold(
        appBar: appBar(title: "Collecting New Data", bottomBarTitle: "First Pass"),
        body: new Column(
          children: <Widget>[
            new Expanded(
                child: new ListView.builder(
                    itemCount: dataList?.length ?? 0,
                    itemBuilder: (BuildContext ctx, int index) {
                      return new FoodItemCard(
                          onChanged: (itemData) => dataList[index] = itemData,
                          initialItemData: dataList[index]
                      );
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



class FoodItemCard extends StatefulWidget {

  final FoodItem initialItemData;
  final ValueChanged<FoodItem> onChanged;

  const FoodItemCard({Key key, @required this.onChanged, this.initialItemData}): super(key: key);

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {

  static const double edge_inset = 9.0;

  FoodItem itemData;

  TextEditingController foodNameController = TextEditingController();

  @override void initState() {

    // Initialise itemData if there is initial data
    if (widget.initialItemData == null) itemData = FoodItem();
    else itemData = widget.initialItemData;

    // Initialise foodNameController and set state to be itemData.foodName if available
    foodNameController.addListener((){
      itemData.foodName = foodNameController.text;
      widget.onChanged(itemData);
    });
    foodNameController.text = itemData?.foodName ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
//      height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all (edge_inset),
              child: question(
                  questionText: "What did you eat this morning?",
                  hint:"Input food here",
                  controller: foodNameController,
                  //onChanged: (text) => widget.itemData.foodName = text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(edge_inset),
              child: TimePicker(
                onChanged: (time) {itemData.timeOfDay = time; widget.onChanged(itemData);},
                onConfirm: (time) {itemData.timeOfDay = time; widget.onChanged(itemData);},
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