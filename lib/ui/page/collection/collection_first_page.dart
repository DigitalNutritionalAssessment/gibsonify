import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';


import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';



class FoodItemList extends StatefulWidget {

  final navigatePageState;
  final List<FoodItem> initialFoodList;
  final updatePageState;
  final Map<String,FoodItem> recipeMap;

  const FoodItemList({
    @required this.navigatePageState,
    @required this.updatePageState,
    @required this.recipeMap,
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
    print(widget.recipeMap);
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
                print(foodItem.recipe.recipeType);
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


