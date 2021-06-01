import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';

//import 'package:flutter_uikit/database/icrisat_database.dart';

import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';
import 'package:flutter_uikit/ui/decorations.dart';

class FoodItemList2 extends StatefulWidget {
  //final navigatePageState;
  final navigatePageStateForward;
  final navigatePageStateBack;
  final navigateHome;
  final updatePageState;
  final initialFoodList;
  final Map<String, FoodItem> recipeMap;
  final Map<String, int> fctMap;
  final Map<String, int> rCodeMap;

  const FoodItemList2({
    //@required this.navigatePageState,
    @required this.navigatePageStateForward,
    @required this.navigatePageStateBack,
    @required this.updatePageState,
    @required this.navigateHome,
    this.recipeMap,
    this.initialFoodList,
    this.fctMap,
    this.rCodeMap,
    //this.rCodeMap, Null Function() navigatePageStateBack, Null Function() navigatePageStateForward,
  });

  //Alert
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Close"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Help"),
      content: Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
                'This pass is to ensure that more detail of the food will be collected, these include:'),
          ),
          new ListTile(
            leading: new MyBullet(),
            title: new Text('Description of the food item or dish'),
          ),
          new ListTile(
            leading: new MyBullet(),
            title: new Text('Form when eaten'),
          ),
          new ListTile(
            leading: new MyBullet(),
            title: new Text('Recipe number, for standard recipe'),
          )
        ],
      ),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  _FoodItemList2State createState() => _FoodItemList2State();
}

class _FoodItemList2State extends State<FoodItemList2> {
  // ignore: deprecated_member_use
  List<FoodItem> _foodList = List<FoodItem>();

  Map<String, int> _fctMap = {};
  Map<String, FoodItem> _recipeMap = {};
  Map<String, int> _rCodeMap = {};

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.initialFoodList != null) _foodList = widget.initialFoodList;
    if (widget.fctMap != null) _fctMap = widget.fctMap;
    if (widget.rCodeMap != null) _rCodeMap = widget.rCodeMap;
    if (widget.recipeMap != null) _recipeMap = widget.recipeMap;
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
                    onDismissed: (direction) {
                      setState(() {
                        _foodList.removeAt(index);
                        widget.updatePageState(_foodList);
                      });
                    },
                    child: SecondPassFoodItemCard(
                      updateFoodItemState: (foodItem) {
                        _foodList[index] = foodItem;
                      },
                      foodItem: _foodList[index],
                      recipeMap: _recipeMap,
                      fctMap: _fctMap,
                      rCodeMap: _rCodeMap,
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
              ElevatedButton(
                child: const Text('First Pass'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  //final form = _formKey.currentState;
                  //if (form.validate()) {
                  //form.save();
                  widget.updatePageState(_foodList);
                  widget.navigatePageStateBack();
                  //}
                },
              ),
              ElevatedButton(
                child: const Text('Home Page'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    widget.updatePageState(_foodList);
                    widget.navigateHome();
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Help'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    widget.updatePageState(_foodList);
                    widget.showAlertDialog(context);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Probe List'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    widget.updatePageState(_foodList);
                    widget.navigatePageStateForward();
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

class SecondPassFoodItemCard extends StatelessWidget {
  final FoodItem foodItem;
  final updateFoodItemState;
  final Map<String, int> fctMap;
  final Map<String, int> rCodeMap;
  final Map<String, FoodItem> recipeMap;
  final bool enabled;

  const SecondPassFoodItemCard({
    @required this.foodItem,
    @required this.updateFoodItemState,
    this.recipeMap,
    this.fctMap,
    this.rCodeMap,
    this.enabled,
  });

  Future<void> getSourceCode(int sourceCode) async {
    //function which rebuilds page when Source Code changed
    // ignore: await_only_futures
    int _code = await sourceCode;
    //ignore error above
    print('Source updated to ${SourceOfFoodSelection.values[_code]}');
  }

  @override
  Widget build(BuildContext context) {
    bool _firstbuild = true;
    return Card(
      elevation: 2.0,
      child: Container(
        child: Column(
          children: <Widget>[
            AutoCompleteTextField(
              suggestions: recipeMap?.keys?.toList() ?? [],
              onSuggestionSelected: (String selected) {
                foodItem.foodName = selected;

                FoodItem selectedRecipe = recipeMap[selected] ?? FoodItem();

                foodItem.recipe = selectedRecipe.recipe;

                // Only update the ingredientsItems list if the recipe type is standard!
                // If the recipe type is modified, then we assume that the recipe
                // has been previously intentionally modified
                // and hence
                if ((foodItem.recipe.recipeType ?? RecipeType.STANDARD) ==
                    RecipeType.STANDARD) {
                  foodItem.ingredientItems = selectedRecipe.ingredientItems;
                }
                updateFoodItemState(foodItem);
              },
              questionText: "Can you name me something that you've eaten?",
              hintText: null,
              initialText: foodItem.foodName ?? "",
              enabled: (enabled ?? true),
              validate: emptyFieldValidator,
            ),

            DialogPicker(
              questionText: "Source of Food",
              optionsList:
                  FormStrings.sourceOfFoodOutcomeSelection.values.toList(),
              onConfirm: (List<int> values) {
                foodItem.foodSource = SourceOfFoodSelection.values[values[0]];
                updateFoodItemState(foodItem);
                print('Source selected');
                //following code updates the widget when it is changed and avoids error on first build
                if (_firstbuild == true) {
                  _firstbuild = false;
                  print('First Build');
                } else {
                  (context as Element).markNeedsBuild();
                  print('update widget');
                }
              },
              enabled: enabled,
            ),
            FormQuestion(
              questionText: "If other, please specify",
              hint: "",
              //validate so only applies if other is selected above, not working
              validate: (answer) {
                if (foodItem.foodSource == SourceOfFoodSelection.OTHER) {
                  return emptyFieldValidator(answer);
                } else {
                  if (answer.length > 0) {
                    return 'Field should be blank';
                  } else {
                    return null;
                  }
                }
              },
              onSaved: (answer) {
                foodItem.foodSourceOther = answer;
                updateFoodItemState(foodItem);
              },
              enabled: true,
            ),
            RecipeExpansionTile(
              foodItem: foodItem,
              updateFoodItemState: updateFoodItemState,
              fctMap: fctMap,
              initiallyExpanded: true,
              rCodeMap: rCodeMap,
            ),

//            DialogPicker(
//                questionText: "Form When Eaten",
//                optionsList: FormStrings.formWhenEatenSelection.values
//                    .toList(),
//                onConfirm: (List<int> values) {
//                  foodItem.ingredientItems[0].formWhenEaten = FormWhenEatenSelection.values[values[0]];
//                  updateFoodItemState(foodItem);
//                },
//                enabled: enabled,
//            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
