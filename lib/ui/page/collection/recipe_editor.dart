import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/utils/form_strings.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/model/food_item.dart';


class RecipeCard extends StatefulWidget {

  final Recipe recipe;
  final List<IngredientItem> ingredientItems;
  final updateFoodItemState;
  final Map<String,int> fctMap;
  final bool enabled;

  const RecipeCard({
    @required this.recipe,
    @required this.updateFoodItemState,
    @required this.ingredientItems,
    this.fctMap,
    this.enabled,
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {

  List<IngredientItem> _ingredientItems = [];

  @override
  void initState() {
    if (widget.ingredientItems != null) _ingredientItems = widget.ingredientItems;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: UIData.ralewayFont),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Recipe: " + (widget.recipe.description??""),
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: (_ingredientItems?.length ?? 0),
                itemBuilder: (BuildContext ctx, int idx){
                  return Dismissible(
                    key: ObjectKey(_ingredientItems[idx]),
                    onDismissed: (direction){
                      setState(() {
                        _ingredientItems.removeAt(idx);
                        widget.updateFoodItemState(_ingredientItems);
                      });
                    },
                    child: IngredientCard(
                      updateIngredientItemState: (ingredientItem){
                        _ingredientItems[idx] = ingredientItem;
                      },
                      ingredientItem: _ingredientItems[idx],
                      fctMap: widget.fctMap,
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientCard extends StatefulWidget {

  final IngredientItem ingredientItem;
  final updateIngredientItemState;
  final Map<String,int> fctMap;
  final bool enabled;

  const IngredientCard({
    @required this.ingredientItem,
    @required this.updateIngredientItemState,
    this.fctMap,
    this.enabled,
  });

  @override
  _IngredientCardState createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AutoCompleteTextField(
            suggestions: widget.fctMap?.keys?.toList() ?? [],
            onSuggestionSelected: (String selected) {
              widget.ingredientItem.foodItemName = selected;
              widget.updateIngredientItemState(widget.ingredientItem);
            },
            questionText: "Food Item Description",
            hintText: null,
            initialText: widget.ingredientItem.foodItemName ?? "",
            enabled: widget.enabled,
            validate: emptyFieldValidator,
          ),
          AutoCompleteTextField(
            suggestions: widget.fctMap?.keys?.toList() ?? [],
            onSuggestionSelected: (String selected) {
              widget.ingredientItem.foodGroup = selected;
              widget.updateIngredientItemState(widget.ingredientItem);
            },
            questionText: "Food Group",
            hintText: null,
            initialText: widget.ingredientItem.foodGroup ?? "",
            enabled: widget.enabled,
            validate: emptyFieldValidator,
          ),
          DialogPicker(
            questionText: "Form When Eaten",
            optionsList: FormStrings.formWhenEatenSelection.values
                .toList(),
            onConfirm: (List<int> values) {
              widget.ingredientItem.formWhenEaten =
              FormWhenEatenSelection.values[values[0]];
              widget.updateIngredientItemState(widget.ingredientItem);
            },
            enabled: widget.enabled,
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
