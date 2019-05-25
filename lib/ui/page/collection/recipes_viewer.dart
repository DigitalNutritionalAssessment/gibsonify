import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';

class RecipeItemList extends StatefulWidget {

  final navigatePageStateBack;
  final navigatePageStateForward;
  final updatePageState;
  final initialFoodList;
  final Map<String,int> fctMap;

  const RecipeItemList({
    @required this.navigatePageStateBack,
    @required this.navigatePageStateForward,
    @required this.updatePageState,
    this.initialFoodList,
    this.fctMap
  });

  @override
  _RecipeItemListState createState() => _RecipeItemListState();
}

class _RecipeItemListState extends State<RecipeItemList> {

  List<FoodItem> _foodList = new List<FoodItem>();

  @override
  void initState() {
    if (widget.initialFoodList != null) _foodList = widget.initialFoodList;
    super.initState();
  }

  List<Widget> _getChildren(){
    List<Widget> children = [];
    _foodList.asMap().forEach((index, foodItem) {
      children.add(
        new RecipeExpansionTile(
          foodItem: foodItem,
          updateFoodItemState: (item){
            _foodList[index] = item;
            widget.updatePageState(_foodList);
          },
          fctMap:widget.fctMap,
        )
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: _getChildren(),
          ),
        ),
        new FittedBox(
          fit: BoxFit.contain,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: const Text('Go back to Second Pass'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  widget.navigatePageStateBack();
                },
              ),
              RaisedButton(
                child: const Text('Go to Fourth Pass'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: () {
                    widget.navigatePageStateForward();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class RecipeExpansionTile extends StatefulWidget {

  final FoodItem foodItem;
  final updateFoodItemState;
  final Map<String,int> fctMap;
  final bool enabled;

  RecipeExpansionTile({
    @required this.foodItem,
    @required this.updateFoodItemState,
    this.fctMap,
    this.enabled,
});

  @override
  _RecipeExpansionTileState createState() => _RecipeExpansionTileState();
}

class _RecipeExpansionTileState extends State<RecipeExpansionTile> {

  PageStorageKey _key;

  FoodItem _foodItem;

  Map<String,int> _fctMap = Map<String,int>();

  final GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.foodItem != null) _foodItem = widget.foodItem;
    if (widget.fctMap != null) _fctMap = widget.fctMap;
    super.initState();
  }

  void markRecipeNonStandard(){
    _foodItem.recipe.recipeType = RecipeType.MODIFIED;
  }

  @override
  Widget build(BuildContext context) {
    _key = new PageStorageKey("${_foodItem.recipe.description}");

    List<Widget> _getChildren(){
      List<Widget> output = [];
      for (int i =0; i< _foodItem.ingredientItems.length; i++){
        output.add(Dismissible(
          key: Key(_foodItem.ingredientItems[i].foodItemName ?? ""),
          onDismissed: (direction){
            markRecipeNonStandard();
            setState(() {
              _foodItem.ingredientItems.removeAt(i);
              widget.updateFoodItemState(_foodItem);
            });
          },
          child: ListTile(
            dense:true,
            title: Text(
                _foodItem.ingredientItems[i].foodItemName ?? ""
            ),
            onTap: () => showUpdateRecipeDialog(
                parentContext: context,
                title: (widget.enabled??true) ? "Update Ingredient" : "View Ingredient", // View ingredient only if enabled is false
                updateIngredientState: (ingredient){
                  markRecipeNonStandard();
                  _foodItem.ingredientItems[i] = ingredient;
                  widget.updateFoodItemState(_foodItem);
                  },
                ingredientItem: _foodItem.ingredientItems[i],
                formKey: _formKey,
                enabled: (widget.enabled??true),
            ),

          ),
        ));
      }

      // Add an "Add" button only if widget.enabled is true
      (widget.enabled??true) ? output.add(ListTile(
        dense:true,
        title: Icon(Icons.add_circle_outline),
        onTap: () {
            IngredientItem newIngredient = IngredientItem();
            _foodItem.ingredientItems.add(newIngredient);
            showUpdateRecipeDialog(
                parentContext: context,
                title: "Add New Ingredient",
                updateIngredientState: (ingredient){
                  _foodItem.ingredientItems[_foodItem.ingredientItems.length-1] = ingredient;
                  markRecipeNonStandard();
                  },
                ingredientItem: newIngredient,
                enabled: true
            );
        },
      )) : null;
      return output;
    }

    return ExpansionTile(
      key:_key,
      title: Text(
        _foodItem.recipe.description ?? _foodItem.foodName ?? "",
        style: (widget.enabled??true) ? null : UIData.smallTextStyle,
      ),
      children: _getChildren(),

    );
  }

  void showUpdateRecipeDialog({
      BuildContext parentContext,
      String title,
      updateIngredientState,
      IngredientItem ingredientItem,
      GlobalKey<FormState> formKey,
      bool enabled}) {

    final _formKey = GlobalKey<FormState>();


    showDialog(
        context: parentContext,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: new Text(title),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AutoCompleteTextField(
                      suggestions: widget.fctMap?.keys?.toList() ?? [],
                      onSuggestionSelected: (String selected) {
                        ingredientItem.foodItemName = selected;

//                    FoodItem selectedRecipe = recipeMap[selected]?? FoodItem();
//                    foodItem.recipe = selectedRecipe.recipe;
//                    foodItem.ingredientItems = selectedRecipe.ingredientItems;
//                      updateIngredientState(ingredientItem);
                      },
                      questionText: "Ingredient Name",
                      hintText: null,
                      initialText: ingredientItem.foodItemName ?? "",
                      validate: emptyFieldValidator,
                      enabled: (enabled??true),
                    ),
                    DialogPicker(
                      questionText: "Form When Eaten",
                      optionsList: FormStrings.formWhenEatenSelection.values
                          .toList(),
                      onConfirm: (List<int> values) {
                        ingredientItem.formWhenEaten =
                        FormWhenEatenSelection.values[values[0]];
//                      updateIngredientState(ingredientItem);
                      },
                      enabled: (enabled??true),
                    ),
                    FormQuestion(
                      questionText: "grams/ml",
                      initialText: ((ingredientItem.measurement?? 0) * 100).toStringAsPrecision(2)??"", // Convert 100s of grams to grams
                      hint: "",
                      validate: emptyFieldValidator,
                      onSaved: (answer) {
                        ingredientItem.measurement = (0.001 * (double.tryParse(answer)??0));
                        print(ingredientItem.measurement.toString());
                        print(answer);
//                    updateIngredientState(ingredientItem);
                      },
                      enabled: (enabled??true),
                    ),
                    DialogPicker(
                      questionText: "Measurement Units",
                      optionsList: FormStrings.measurementUnitSelection.values
                          .toList(),
                      onConfirm: (List<int> values) {
                        ingredientItem.measurementUnit =
                        MeasurementUnitSelection.values[values[0]];
//                      updateIngredientState(ingredientItem);
                      },
                      enabled: (enabled??true),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              //Provide an update button only if enabled is true
              (enabled??true) ? new FlatButton(
                child: new Text("Update"),
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    updateIngredientState(ingredientItem);
                  }
                  Navigator.of(ctx).pop();
                },
              ) : null,
            ],
          );
        }
    );
  }
}



