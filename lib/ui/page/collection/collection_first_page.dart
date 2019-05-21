import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';


import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';



class FoodItemList extends StatefulWidget {

  final navigatePageState;
  final initialFoodList;
  final updatePageState;

  const FoodItemList({
    @required this.navigatePageState,
    @required this.updatePageState,
    this.initialFoodList,
  });

  @override
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {

  List<FoodItem> _foodList = List<FoodItem>();
  ValueChanged<List<FoodItem>> updatePageState;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.initialFoodList != null) _foodList = widget.initialFoodList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key:_formKey,
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              itemCount: _foodList.length ?? 0,
              itemBuilder: (BuildContext ctx, int index) {
                return Dismissible(
                    key: ObjectKey(_foodList[index]),
                    onDismissed: (direction){
                      setState(() {
                        _foodList.removeAt(index);
                        widget.updatePageState(_foodList);
                      });
                    },
                    child: FoodItemCard(
                        updateFoodItemState: (foodItem){
                            _foodList[index] = foodItem;
                        },
                      foodItem: _foodList[index],
                    ));
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
                    setState(() {
                      _foodList.add(FoodItem());
                    });
                  },
                ),
                RaisedButton(
                  child: const Text('Go to Second Pass'),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {

                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      widget.updatePageState(_foodList);
                      widget.navigatePageState();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class FoodItemCard extends StatelessWidget {

  final FoodItem foodItem;
  final updateFoodItemState;
  final bool enabled;

  const FoodItemCard({
    @required this.foodItem,
    @required this.updateFoodItemState,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2.0,
      child: Container(
//      height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            FormQuestion(
              questionText: "Can you name me something that you've eaten?",
              hint: "Input food name here",
              initialText: foodItem.foodName,
              validate: emptyFieldValidator,
              onSaved: (answer)
              {
                foodItem.foodName = answer;
                updateFoodItemState(foodItem);
              },
              enabled: (enabled ?? true),
            ),
            DialogPicker(
              questionText: "What time did you eat it?",
              optionsList: FormStrings.timeOfDaySelection.values.toList(),
              onConfirm: (List<int> values) {
                foodItem.timeOfDay = TimeOfDaySelection.values[values[0]];
              updateFoodItemState(foodItem);
              },
              initialSelectedOption: 0,
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


