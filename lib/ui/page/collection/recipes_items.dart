import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';

import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';


class RecipeItemList extends StatefulWidget {

  final VoidCallback navigatePageStateBack;
  final VoidCallback navigatePageStateForward;
  final VoidCallback navigateHome;
  final ValueChanged<List<FoodItem>> updatePageState;
  final List<FoodItem> initialFoodList;
  final Map<String,int> fctMap;
  final Map<String,int> rCodeMap;
  final bool initiallyExpanded;

  const RecipeItemList({
    @required this.navigatePageStateBack,
    @required this.navigatePageStateForward,
    @required this.updatePageState,
    @required this.navigateHome,
    this.initialFoodList,
    this.fctMap,
    this.rCodeMap,
    this.initiallyExpanded,
  });

  @override
  _RecipeItemListState createState() => _RecipeItemListState();
}

class _RecipeItemListState extends State<RecipeItemList> {

  // ignore: deprecated_member_use
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
          initiallyExpanded: (widget.initiallyExpanded??true),
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
              ElevatedButton(
                child: const Text('Go back to Second Pass'),
                //color: Theme.of(context).accentColor,
                //elevation: 4.0,
                //splashColor: Colors.blueGrey,
                onPressed: () {
                  widget.navigatePageStateBack();
                },
              ),
              ElevatedButton(
                child: const Text('Home Page'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent,                      
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                onPressed: () {
                    widget.navigateHome();
                },
              ),
              ElevatedButton(
                child: const Text('Go to Fourth Pass'),
                //color: Theme.of(context).accentColor,
                //elevation: 4.0,
                //splashColor: Colors.blueGrey,
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
  final Map<String,int> rCodeMap;
  final bool enabled;
  final bool initiallyExpanded;
  final bool listInsteadOfExpansionTile;
  final bool modifyLocked;
  final bool newRecipe;

  RecipeExpansionTile({
    @required this.foodItem,
    @required this.updateFoodItemState,
    this.fctMap,
    this.rCodeMap,
    this.enabled,
    this.initiallyExpanded,
    this.listInsteadOfExpansionTile,
    this.modifyLocked,
    this.newRecipe,
});

  @override
  _RecipeExpansionTileState createState() => _RecipeExpansionTileState();
}

class _RecipeExpansionTileState extends State<RecipeExpansionTile> {

  PageStorageKey _key;

  FoodItem _foodItem;

  bool modifyLocked;

  bool newRecipe;

  @override
  void initState() {
    if (widget.foodItem != null) _foodItem = widget.foodItem;
    // if (widget.fctMap != null) _fctMap = widget.fctMap;
    // if (widget.rCodeMap != null) _rCodeMap = widget.rCodeMap;
    if (widget.modifyLocked != null) modifyLocked = widget.modifyLocked;
    else modifyLocked = (_foodItem.recipe.recipeType != RecipeType.MODIFIED);

    super.initState();
  }

  void markRecipeNonStandard() async {
    _foodItem.recipe.recipeType = RecipeType.MODIFIED;
    modifyLocked = false;

    String nextID = await IcrisatDB().getNextModifiedRecipeID();
    _foodItem.recipe.id = nextID;
    
   if (!_foodItem.recipe.description.contains("_"))
    _foodItem.recipe.description = _foodItem.recipe.description + "_" + nextID ;

    widget.updateFoodItemState(_foodItem);

  }

  String generateRecipeName(){
    String name = (_foodItem.recipe.description ?? _foodItem.foodName ?? "");
    if (_foodItem.recipe.recipeType == RecipeType.MODIFIED) name = name + " (modified)";
    else if (_foodItem.recipe.recipeType == RecipeType.STANDARD) name = name + " (standard)";
    return name;
  }

  List<Widget> getChildren(BuildContext context){

    Uuid uuid = Uuid();

    List<Widget> output = [];
    for (int i =0; i< _foodItem.ingredientItems.length; i++){
      output.add(Dismissible(
        key: Key(uuid.v1().toString()),
//        Key(
//          (_foodItem.recipe.id?? "") +
//          (_foodItem.ingredientItems[i].foodItemName ?? "") +
//          (_foodItem.ingredientItems[i].measurement??0).toString()
//        ),
        onDismissed: (direction){
          if (modifyLocked){
            showModifyLockedDialog(
              parentContext: context,
              setModifyLockedBool: markRecipeNonStandard,
              onModifyCallBack: () => setState(() {
                  _foodItem.ingredientItems.removeAt(i);
                  widget.updateFoodItemState(_foodItem);
                }),
            );
          }
          else {
            setState(() {
              _foodItem.ingredientItems.removeAt(i);
              widget.updateFoodItemState(_foodItem);
            });
          }
          
        },
        child: ListTile(
          dense:true,
          title: Text(
              _foodItem.ingredientItems[i].foodItemName ?? "",
          ),
          onTap: () {
            if (widget.enabled ?? true){
              if (modifyLocked){
                showModifyLockedDialog(
                    parentContext: context,
                    setModifyLockedBool: markRecipeNonStandard,
                    onModifyCallBack: () => updateIngredientItemInRecipe(index: i, enabled: true),
                    onViewOnlyCallback: () => updateIngredientItemInRecipe(index: i, enabled: false)
                );
              }
              else updateIngredientItemInRecipe(index: i, enabled: true);
            }
            else updateIngredientItemInRecipe(index: i, enabled: false);
          },

        ),
      ));
    }

    // Add an "Add" button only if widget.enabled is true
    (widget.enabled??true) ? output.add(ListTile(
      dense:true,
      title: Icon(Icons.add_circle_outline),
      onTap: () {

        if (modifyLocked){
          showModifyLockedDialog(
              parentContext: context,
              setModifyLockedBool: markRecipeNonStandard,
              onModifyCallBack: addIngredientItemIntoRecipe,
              );
        }
        else addIngredientItemIntoRecipe();
      },
    // ignore: unnecessary_statements
    )): null ;
    return output;
  }


  @override
  Widget build(BuildContext context) {
    if (widget.listInsteadOfExpansionTile ?? false){
      return ListView(
        children: getChildren(context),
      );
    }
    else{
      return ExpansionTile(
        key:_key,
        title: Text(
          //_foodItem.recipe.description ?? _foodItem.foodName ?? "",
          generateRecipeName(),
          style: (widget.enabled??true) ? null : UIData.smallTextStyle,
        ),
        children: getChildren(context),
        initiallyExpanded: (widget.initiallyExpanded ?? true),
      );
    }

  }

  void updateIngredientItemInRecipe({int index, bool enabled}){
    showUpdateRecipeDialog(
      parentContext: context,
      title: (widget.enabled ?? true)
          ? "Update Ingredient"
          : "View Ingredient",
      // View ingredient only if enabled is false
      updateIngredientState: (ingredient) {
        _foodItem.ingredientItems[index] = ingredient;
        print(_foodItem.recipe.id);
        widget.updateFoodItemState(_foodItem);
      },
      ingredientItem: _foodItem.ingredientItems[index],
      enabled: (enabled ?? widget.enabled),
    );
  }

  void addIngredientItemIntoRecipe(){
    IngredientItem newIngredient = IngredientItem();
    _foodItem.ingredientItems.add(newIngredient);
    showUpdateRecipeDialog(
        parentContext: context,
        title: "Add New Ingredient To Recipe",
        updateIngredientState: (ingredient){
          _foodItem.ingredientItems[_foodItem.ingredientItems.length-1] = ingredient;
        },
        ingredientItem: newIngredient,
        enabled: true
    );
  }

  Future<void> showModifyLockedDialog({
    BuildContext parentContext,
    VoidCallback setModifyLockedBool,
    VoidCallback onModifyCallBack,
    VoidCallback onViewOnlyCallback,
  }){
    return showDialog<void>(
        context: parentContext,
        builder: (BuildContext context) {
            return SimpleDialog(
                title: Text("Are you sure you want to modify the recipe?"),
                children: <Widget>[
                    SimpleDialogOption(
                      child: new Text('Create a new modified recipe!'),
                      onPressed: (){
                        setModifyLockedBool();
                        Navigator.of(context).pop();
                        onModifyCallBack();
                      }
                    ),
                    (onViewOnlyCallback != null) ? SimpleDialogOption(
                      child: new Text('View Ingredient Only'),
                      onPressed: (){
                        Navigator.of(context).pop();
                        onViewOnlyCallback();
                      }
                    ): null,
                    SimpleDialogOption(
                        child: new Text('Cancel'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }
                    ),
                ]..removeWhere((widget) => widget == null),
            );
        }
    );
  }

  Future<void> showUpdateRecipeDialog({
      BuildContext parentContext,
      String title,
      ValueChanged<IngredientItem> updateIngredientState,
      IngredientItem ingredientItem,
      bool enabled}) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//    final GlobalKey _formKey = new GlobalKey<FormState>();

    return showDialog<void>(
        context: parentContext,
        builder: (BuildContext context) {
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
                        ingredientItem.fctCode = widget.fctMap[selected]??0;
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
//                    DialogPicker(
//                      questionText: "Form When Eaten",
//                      optionsList: FormStrings.formWhenEatenSelection.values
//                          .toList(),
//                      onConfirm: (List<int> values) {
//                        ingredientItem.formWhenEaten =
//                        FormWhenEatenSelection.values[values[0]];
////                      updateIngredientState(ingredientItem);
//                      },
//                      enabled: (enabled??true),
//                    ),
                    AutoCompleteTextField(
                      suggestions: widget.rCodeMap?.keys?.toList() ?? [],
                      onSuggestionSelected: (String selected) {
                        ingredientItem.rDescription = selected;
                        ingredientItem.rCode = widget.rCodeMap[selected]??0;
                      },
                      questionText: "Ingredient Description",
                      hintText: null,
                      initialText: ingredientItem.rDescription ?? "",                          // TO DO! Settle this properly please
                      validate: emptyFieldValidator,
                      enabled: (enabled??true),
                    ),
                    DialogPicker(
                      questionText: "Measurement Method",
                      optionsList: FormStrings.measurementMethodSelection.values
                          .toList(),
                      onConfirm: (List<int> values) {
                        ingredientItem.measurementMethod =
                        MeasurementMethodSelection.values[values[0]];
//                      updateIngredientState(ingredientItem);
                      },
                      initialSelectedOption: ingredientItem.measurementMethod?.index ?? 0,
                      enabled: (enabled??true),
                    ),
                    FormQuestion(
                      questionText: "Measurement Number",
//                      initialText: ((ingredientItem.measurementUnit == MeasurementUnitSelection.GRAMS) ? ((ingredientItem.measurement?? 0)*100).round().toString() : (ingredientItem.measurement?? 0).toStringAsPrecision(2)),
                      initialText: ((ingredientItem.measurement??0) < 10) ? ingredientItem.measurement?.toStringAsPrecision(3) : ingredientItem.measurement?.round().toString(),
                      hint: "",
                      validate: emptyFieldValidator,
                      onSaved: (answer) {
                        ingredientItem.measurement = double.tryParse(answer)??0;
//                        ingredientItem.measurement = ((ingredientItem.measurementUnit == MeasurementUnitSelection.GRAMS) ? ((double.tryParse(answer)??0)/100) : double.tryParse(answer) ?? 0);
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
                      initialSelectedOption: ingredientItem.measurementUnit?.index ?? 1,
                      enabled: (enabled??true),
                    ),

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new TextButton( //FlatButton
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
//                    Navigator.popUntil(context, ModalRoute.withName(UIData.newCollectionSessionRoute));
                },
              ),
              //Provide an update button only if enabled is true
              (enabled??true) ? new TextButton( //FlatButton
                child: new Text("Update"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    updateIngredientState(ingredientItem);
                  }
                },
              ) : null,
            ],
          );
        }
    );
  }
}



