import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/ui/page/collection/collection_page_common_widgets.dart';
import 'package:flutter_uikit/model/food_item.dart';
import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';
import 'package:flutter_uikit/database/icrisat_database.dart';


class RecipeViewer extends StatefulWidget {
  @override
  _RecipeViewerState createState() => _RecipeViewerState();
}

class _RecipeViewerState extends State<RecipeViewer> {

  Map<String,FoodItem> _recipeMap;
  Map<String,int> _fctMap;
  Map<String,int> _rCodeMap;

  List <FoodItem> standardRecipeList = [];
  List <FoodItem> modifiedRecipeList = [];
  List <FoodItem> recentlyChangedRecipeList = [];

  //List <FoodItem> _foodList = <FoodItem>[];


  @override
  void initState(){
    getRecipeDataAndFctMap();
    super.initState();
  }

  Future getRecipeDataAndFctMap() async{
    _fctMap = await IcrisatDB().mapDescriptionToFCTCode();
    _rCodeMap = await IcrisatDB().mapFoodDescriptionToRCode();
    await updateRecipeData();
  }

  Future updateRecipeData() async{
    _recipeMap = await IcrisatDB().getRecipeInformation();
    setState(() {

      // Clear the recipe datas
      //standardRecipeList = [];
      //modifiedRecipeList = [];

      for (MapEntry<String,FoodItem> entry in _recipeMap?.entries ?? {}){
        if (entry.value.recipe.recipeType == RecipeType.STANDARD)
          standardRecipeList.add(entry.value);
        else if (entry.value.recipe.recipeType == RecipeType.MODIFIED)
          modifiedRecipeList.add(entry.value);
      }
    });
  }


  List<Widget> _getChildren(
    List<FoodItem> foodList, 
    ValueChanged<FoodItem> updateFoodItemState, 
    bool modifyLocked, 
    ValueChanged<int> onDismissedCallback,
    ){
    List<Widget> children = [];

    Widget recipeTile(foodItem){
      return RecipeExpansionTile(
            foodItem: foodItem,
            updateFoodItemState: updateFoodItemState,
            fctMap: _fctMap,
            rCodeMap: _rCodeMap,
            initiallyExpanded: false,
            modifyLocked: (modifyLocked??true),
          );
    }

    foodList.asMap().forEach((index, foodItem) {
      children.add(
        ((onDismissedCallback !=null) ? Dismissible(
          key: Key((foodItem.foodName??foodItem.recipe.description)??"" + foodItem.recipe.id),
          onDismissed: (direction){
            onDismissedCallback(index);
          },
          child: recipeTile(foodItem),
        ): recipeTile(foodItem)),
      );
    });
    return children;
  }

  Widget recipeCard({
    BuildContext parentContext,
    List<FoodItem> recipeList, 
    String title, 
    ValueChanged<FoodItem> updateFoodItemState, 
    bool modifyLocked,
    ValueChanged<int> onDismissedCallback,
    }){
    return Column(
      children: <Widget>[
        Expanded(
          child: Card(
          elevation: 2.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Text(
              //   title,
              //   textAlign: TextAlign.center,
              //   style:UIData.titleTextStyle,
              //   ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:  _getChildren(recipeList, updateFoodItemState, modifyLocked, onDismissedCallback),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
        new FittedBox(
          fit: BoxFit.contain,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Add New Recipe'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  elevation: 4.0,
                  onPrimary: Colors.blueGrey,
                ),
                onPressed: () async {
                  Navigator.popAndPushNamed(context, UIData.NewRecipeRoute);
                },
              ),
              ElevatedButton(
                child: const Text('View Changes'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  elevation: 4.0,
                  onPrimary: Colors.blueGrey,
                ),
                onPressed: () async {
                  DefaultTabController.of(parentContext).animateTo(2);
                },
              ),
            ],
          ),
        ),
        ],
      );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (BuildContext context){
        return Scaffold(
          appBar: appBar(title: "View Recipes",
              bottomBarTitle: "",
              tabs: [
                Tab(text: "Standard"),
                Tab(text: "Modified"),
                Tab(text: "Changed"),
              ]),
          body: TabBarView(
            children: <Widget>[
              recipeCard(
                parentContext: context,
                recipeList: standardRecipeList,
                title: "Standard",
                updateFoodItemState: (item) async {
                  recentlyChangedRecipeList.add(item);
                  await IcrisatDB().updateRecipes(item);
                  await updateRecipeData();
                },
                modifyLocked: true,
                ),
              recipeCard(
                parentContext: context,
                recipeList: modifiedRecipeList,
                title: "Modified",
                updateFoodItemState: (item) async {
                  recentlyChangedRecipeList.add(item);
                  await IcrisatDB().updateRecipes(item);
                  await updateRecipeData();
                },
                onDismissedCallback: (indexToDismiss){
                  IcrisatDB().deleteRecipe(modifiedRecipeList[indexToDismiss]);
                  setState(() {
                    modifiedRecipeList.removeAt(indexToDismiss);
                  });
                },
                modifyLocked: false,
                ),
                 recipeCard(
                  parentContext: context,
                  recipeList: recentlyChangedRecipeList.toSet().toList(),
                  title: "Recently Changed",
                  updateFoodItemState: (item) async {
                    await IcrisatDB().updateRecipes(item);
                    await updateRecipeData();
                  },
                  modifyLocked: false,
                ),
            ],
            ),
        );
      },
      ),
    );
  }
}