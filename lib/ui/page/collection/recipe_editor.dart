import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/utils/form_strings.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';


import 'package:flutter_uikit/ui/page/collection/collection_page_common_widgets.dart';


import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';
import 'package:flutter_uikit/database/icrisat_database.dart';


class RecipeEditingCard extends StatefulWidget {

  @override
  _RecipeEditingCardState createState() => _RecipeEditingCardState();
}

class _RecipeEditingCardState extends State<RecipeEditingCard> {

  FoodItem foodItem;
  Map<String,int> _fctMap;
  Map<String,int> _rCodeMap;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState(){
    foodItem = FoodItem();
    getRecipeDataAndFctMap();
    super.initState();
  }


  Future getRecipeDataAndFctMap() async{
    var tmpFctMap = await IcrisatDB().mapDescriptionToFCTCode();
    var tmpRCodeMap = await IcrisatDB().mapFoodDescriptionToRCode();
    setState(() {
      _fctMap = tmpFctMap;
      _rCodeMap = tmpRCodeMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(title: "Add New Recipe",
          bottomBarTitle: ""),
      body: Column(
      children: <Widget>[
        Expanded(
          child: Card(
          elevation: 2.0,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormQuestion(
                    questionText: "Recipe Name",
                    hint: "Recipe Name",
                    initialText: "",
                    validate: emptyFieldValidator,
                    onSaved: (answer) {
                      foodItem.recipe.description = answer;
                    }
                ),
                Expanded(
                  child: RecipeExpansionTile(
                    foodItem: foodItem,
                    updateFoodItemState: (food) => {foodItem = food},
                    fctMap: _fctMap,
                    rCodeMap: _rCodeMap,
                    listInsteadOfExpansionTile: true,
                    modifyLocked: false,
                    initiallyExpanded: false,
                  ),
                ),
              ],
            ),
          ),
          ),
        ),
        new FittedBox(
          fit: BoxFit.contain,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Add new data'),
                style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                elevation: 4.0,
                //onPrimary: Colors.blueGrey,
                ),

                onPressed: () async {
                  // To do: Implement Saving

                  // Collect the Food Description
                  final form = _formKey.currentState;
                  form.save();
                  /*if (form.validate()) {
                    form.save();
                  }*/

                  foodItem.recipe.id = await IcrisatDB().getNextModifiedRecipeID();
                  foodItem.recipe.recipeType = RecipeType.MODIFIED;
                  IcrisatDB().updateRecipes(foodItem);
                  Navigator.popAndPushNamed(context, UIData.newCollectionSessionRoute);

                },
              ),
              ElevatedButton(
                child: const Text('Save Recipe'),
                style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                elevation: 4.0,
                //onPrimary: Colors.blueGrey,
                ),
                onPressed: () async {
                  // To do: Implement Saving

                  // Collect the Food Description
                  final form = _formKey.currentState;
                  form.save();
                  /*if (form.validate()) {
                    form.save();
                  }*/

                  foodItem.recipe.id = await IcrisatDB().getNextModifiedRecipeID();
                  print(foodItem.recipe.id);
                  foodItem.recipe.recipeType =RecipeType.MODIFIED;
                  IcrisatDB().updateRecipes(foodItem);
                  Navigator.popAndPushNamed(context, UIData.homeRoute);
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