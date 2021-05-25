import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';

//import 'package:flutter_uikit/database/icrisat_database.dart';

import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';

class FoodItemList2 extends StatefulWidget {

  final navigatePageState;
  final updatePageState;
  final initialFoodList;
  final Map<String,FoodItem> recipeMap;
  final Map<String,int> fctMap;
  final Map<String,int> rCodeMap;


  const FoodItemList2({
    @required this.navigatePageState,
    @required this.updatePageState,
    this.recipeMap,
    this.initialFoodList,
    this.fctMap,
    this.rCodeMap,
  });

  @override
  _FoodItemList2State createState() => _FoodItemList2State();
}

class _FoodItemList2State extends State<FoodItemList2> {

  // ignore: deprecated_member_use
  List<FoodItem> _foodList = List<FoodItem>();

  Map<String,int> _fctMap = {};
  Map<String,FoodItem> _recipeMap = {};
  Map<String,int> _rCodeMap = {};

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
                child: const Text('Add new Food'),
                //color: Theme.of(context).accentColor,
                //elevation: 4.0,
                //splashColor: Colors.blueGrey,
                onPressed: () {
                  setState(() {
                    _foodList.add(FoodItem());
                  });
                  widget.updatePageState(_foodList);
                },
              ),
              ElevatedButton(
                child: const Text('Go to Third Pass'),
                //color: Theme.of(context).accentColor,
                //elevation: 4.0,
                //splashColor: Colors.blueGrey,
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
  final Map<String,int> rCodeMap;
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        child: Column(
          children: <Widget>[
            AutoCompleteTextField(
              suggestions: recipeMap?.keys?.toList() ?? [],
              onSuggestionSelected: (String selected) {
                foodItem.foodName = selected;

                FoodItem selectedRecipe = recipeMap[selected]?? FoodItem();

                foodItem.recipe = selectedRecipe.recipe;

                // Only update the ingredientsItems list if the recipe type is standard!
                // If the recipe type is modified, then we assume that the recipe
                // has been previously intentionally modified
                // and hence
                if ((foodItem.recipe.recipeType??RecipeType.STANDARD) == RecipeType.STANDARD ){
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
                optionsList: FormStrings.sourceOfFoodOutcomeSelection.values
                    .toList(),
                onConfirm: (List<int> values) {
                  foodItem.foodSource = SourceOfFoodSelection.values[values[0]];
                  updateFoodItemState(foodItem);
                },
                enabled: enabled,
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