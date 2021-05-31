import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_uikit/model/consumption_data.dart';

//import 'package:flutter_typeahead/flutter_typeahead.dart';

//import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';


import 'package:flutter_uikit/model/food_item.dart';
import 'package:flutter_uikit/ui/decorations.dart';
import 'package:flutter_uikit/utils/uidata.dart';



class FoodItemList extends StatefulWidget {
  final navigatePageStateForward;
  final List<FoodItem> initialFoodList;
  final updatePageState;
  final Map<String, FoodItem> recipeMap;
  final NewData newData;

  const FoodItemList({
    @required this.navigatePageStateForward,
    @required this.updatePageState,
    @required this.recipeMap,
    this.initialFoodList,
    this.newData,
  });
//Alert
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Close"),
      onPressed:  () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Help"),
      content: Column(
      children: <Widget>[
        new ListTile(
          title: new Text('This pass is to ensure all the normal food is collected, and follows the requirements below:'),
        ),
        new ListTile(
          leading: new MyBullet(),
          title: new Text('It is not too vague'),
        ),
        new ListTile(
          leading: new MyBullet(),
          title: new Text('It cannot involve any cooking methods'),
        ),
        new ListTile(
          leading: new MyBullet(),
          title: new Text('Condiments should be entered separately'),
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
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {
  //List<FoodItem> _foodList = [];
  // ignore: deprecated_member_use
  List<FoodItem> _foodList = List<FoodItem>();
  ValueChanged<List<FoodItem>> updatePageState;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.initialFoodList != null) _foodList = widget.initialFoodList;
    print(widget.recipeMap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new Expanded(
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
                    child: FoodItemCard(
                      updateFoodItemState: (foodItem) {
                        _foodList[index] = foodItem;
                      },
                      foodItem: _foodList[index],
                      recipeMap: widget.recipeMap,
                    ));
              },
            ),
          ),
          new FittedBox(
            fit: BoxFit.contain,
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  //RaisedButton
                  child: const Text('Add new Food'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () {
                    setState(() {
                      _foodList.add(FoodItem());
                    });
                  },
                ),
                ElevatedButton(
                  //RaisedButton
                  child: const Text('Remove Last Item'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,                      
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () {
                    setState(() {
                      _foodList.removeLast();
                    });
                  },
                ),
                ElevatedButton(
                  //RaisedButton
                  child: const Text('Go to Second Pass'),
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
                ElevatedButton(
                  //RaisedButton
                  child: const Text("Help"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () {
                    widget.updatePageState(_foodList);  
                      widget.showAlertDialog(context);                  
                      print(_foodList);
                      print(FoodItem());
                    
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
  final Map<String, FoodItem> recipeMap;

  const FoodItemCard({
    @required this.foodItem,
    @required this.updateFoodItemState,
    this.recipeMap,
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
            /*
              FormQuestion(
                      questionText: "What did you eat today?",
                      hint:"",
                      onSaved: (answer) {
                        foodItem.testing = answer;
                        var widget;
                        widget.updatePageState(foodItem);
                        },
                      enabled: enabled,
                    ),
            */
            
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
                // print(foodItem.recipe.recipeType);
                // if ((foodItem.recipe.recipeType??RecipeType.STANDARD) == RecipeType.STANDARD ){
                //  foodItem.ingredientItems = selectedRecipe.ingredientItems;
                // }
                foodItem.ingredientItems = selectedRecipe.ingredientItems;
                updateFoodItemState(foodItem);
              },
              questionText: "Can you name me something that you've eaten?",
              hintText: "",
              initialText: foodItem.foodName ?? "",
              enabled: (enabled ?? true),
              validate: emptyFieldValidator,
              
              /*
              noItemsFoundBuilder: (BuildContext ctx) {
                return TextButton(
                  //FlatButton
                  child: Text("No Recipes Found! Click to create a new recipe"),
                  onPressed: () =>
                      Navigator.pushNamed(ctx, UIData.NewRecipeRoute),
                      //Push a named route onto the navigator that most tightly encloses the given context.
                );
              },*/
              
            ),
            
            DialogPicker(
              questionText: "What time did you eat it?",
              optionsList: FormStrings.timeOfDaySelection.values.toList(),
              onConfirm: (List<int> values) {
                foodItem.timeOfDay = TimeOfDaySelection.values[values[0]];
                updateFoodItemState(foodItem);
              },
              initialSelectedOption: foodItem?.timeOfDay?.index ?? 0,
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
