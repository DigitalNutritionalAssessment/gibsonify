import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';

class FoodItemList2 extends StatefulWidget {

  final navigatePageState;
  final updatePageState;
  final initialFoodList;

  const FoodItemList2({
    @required this.navigatePageState,
    @required this.updatePageState,
    this.initialFoodList,
  });

  @override
  _FoodItemList2State createState() => _FoodItemList2State();
}

class _FoodItemList2State extends State<FoodItemList2> {

  List<FoodItem> _foodList = List<FoodItem>();

  Map<String,int> _fctMap = {};

  final _formKey = GlobalKey<FormState>();

  Future getFctMap() async{
    var tmpMap = await IcrisatDB().mapDescriptionToFCTCode();
    print(tmpMap);
    setState(() {
      _fctMap = tmpMap;
    });
  }

  @override
  void initState() {
    if (widget.initialFoodList != null) _foodList = widget.initialFoodList;
    getFctMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: Form(
            key: _formKey,
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
              child: SecondPassFoodItemCard(
                updateFoodItemState: (foodItem){
                  _foodList[index] = foodItem;
                },
                foodItem: _foodList[index],
                fctMap: _fctMap,
              ),
            );
            }),
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
                  widget.updatePageState(_foodList);
                },
              ),
              RaisedButton(
                child: const Text('Go to Third Pass'),
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
    );
  }
}


class SecondPassFoodItemCard extends StatelessWidget{

  final FoodItem foodItem;
  final updateFoodItemState;
  final Map<String,int> fctMap;
  final bool enabled;

  const SecondPassFoodItemCard({
    @required this.foodItem,
    @required this.updateFoodItemState,
    this.fctMap,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2.0,
      child: Container(
        child: Column(
          children: <Widget>[
            FormQuestion(
              questionText: "Food Name",
              hint: "",
              initialText: foodItem.foodName,
              validate: emptyFieldValidator,
              onSaved: (answer) {
                foodItem.foodName = answer;
                updateFoodItemState(foodItem);
              },
              enabled: enabled,
            ),
            AutoCompleteTextField(
              suggestions: fctMap?.keys?.toList() ?? [],
              onSuggestionSelected: (String selected){
                foodItem.foodDescription = selected;
                updateFoodItemState(foodItem);
              },
              questionText:"Food Ingredients: ",
              hintText: "Food Ingredient",
              initialText: foodItem.foodDescription ?? "",
              enabled: enabled,
              validate: emptyFieldValidator,
            ),
//            FormQuestion(
//              questionText: "What ingredients were in your food?",
//              hint: "",
//              initialText: foodItem.foodDescription ?? null,
//              validate: emptyFieldValidator,
//              onSaved: (answer){
//                foodItem.foodDescription = answer;
//                updateFoodItemState(foodItem);
//              },
//              enabled: enabled,
//            ),

            DialogPicker(
                questionText: "Source of Food",
                optionsList: FormStrings.sourceOfFoodOutcomeSelection.values
                    .toList(),
                onConfirm: (List<int> values) {
                  foodItem.foodSource = SourceOfFoodSelection.values[values[0]];
                  updateFoodItemState(foodItem);
                },
                enabled: enabled,
            ),
            DialogPicker(
                questionText: "Form When Eaten",
                optionsList: FormStrings.formWhenEatenSelection.values
                    .toList(),
                onConfirm: (List<int> values) {
                  foodItem.formWhenEaten = FormWhenEatenSelection.values[values[0]];
                  updateFoodItemState(foodItem);
                },
                enabled: enabled,
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