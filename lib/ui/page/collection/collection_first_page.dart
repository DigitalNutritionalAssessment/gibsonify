import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/utils/form_strings.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/model/food_item.dart';
import 'package:flutter_uikit/ui/decorations.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter/services.dart';

class FoodItemList extends StatefulWidget {
  final navigatePageStateForward;
  final navigatePageStateBackward;
  final navigateHome;
  final navigateDummy;
  final List<FoodItem> initialFoodList;
  final updatePageState;
  final Map<String, FoodItem> recipeMap;
  final NewData newData;
  final myController =
      TextEditingController(); //myController includes the number they have put in as input

  FoodItemList({
    @required this.navigatePageStateForward,
    @required this.updatePageState,
    @required this.recipeMap,
    @required this.navigatePageStateBackward,
    @required this.navigateHome,
    @required this.navigateDummy,
    this.initialFoodList,
    this.newData,
  });

  showNumberDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Close"),
      onPressed: () => Navigator.pop(context),
    );
    Widget confirmButton = TextButton(
        child: Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.pop(context);
          var digit = int.parse(myController
              .text); //this returns the value of which pass that needs to be exported
          //print(initialFoodList);
          initialFoodList.removeAt(digit - 1);
          //print(initialFoodList);
          return digit;
          //The code below is to test the type
          /*
        print(digit);
        if(digit is int){
          print('it is an integer');
        }
        else if(digit is String){
          print('it is a string');
        }
        */
        });

    // set up the AlertDialog
    AlertDialog confirm = AlertDialog(
      title: Text("Help"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
              'Delete the item by first selecting the number, then deleting the item. This part is to enter your number.'),
          new TextField(
              controller: myController,
              decoration: new InputDecoration(labelText: "Enter your number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
        ],
      ),
      actions: [
        confirmButton, //adds a confirming button to update the number
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return confirm;
      },
    );
    var digit = int.parse(myController.text);
    return digit;
  }

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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        height: 200,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                    'This pass is to ensure all the normal food is collected, replaces Section A of the form and follows the requirements below:'),
              ),
              new ListTile(
                leading: new MyBullet(),
                title: new Text(
                    'All the food items consumed in the past 24 hours, along with time.'),
              ),
              new ListTile(
                leading: new MyBullet(),
                title: new Text('Includes main meal and all stack'),
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
        ),
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
  List<FoodItem> _foodList = <FoodItem>[];
  ValueChanged<List<FoodItem>> updatePageState;
  final _formKey = GlobalKey<FormState>();
  bool pressAttention = false;
  //FoodItemList.myController.text;

  @override
  void initState() {
    if (widget.initialFoodList != null) _foodList = widget.initialFoodList;
    print(widget.recipeMap);
    super.initState();
  }

  Future updateState() async {
    //function which rebuilds page when Day Code changed
    // ignore: await_only_futures
    setState(() {});
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
                      listnumber: _foodList.indexOf(_foodList[index]) + 1,
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
                  child: const Text('Delete Toggle'),
                  style: ElevatedButton.styleFrom(
                      primary: pressAttention
                          ? Theme.of(context).accentColor
                          : Colors.red,
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () =>
                      setState(() => pressAttention = !pressAttention),
                ),
                //This toggling button 
                ElevatedButton(
                    child: const Text('Delete Specific Item'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 4,
                        onSurface: Colors.blueGrey),
                    onLongPress: () {
                      setState(
                        () {
                          _foodList.removeLast();
                        },
                      );
                    },
                    onPressed: () {
                      widget.showNumberDialog(context);
                      updateState();
                    }),
                ElevatedButton(
                  child: const Text("Help"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue[200],
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onLongPress: () {
                    updateState();
                    widget.updatePageState(_foodList);
                    widget.showAlertDialog(context);
                    print(_foodList);
                    print(FoodItem());
                  },
                  onPressed: () {
                    updateState();
                  },
                ),
              ],
            ),
          ),
          new FittedBox(
            fit: BoxFit.contain,
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Go to Interview Info'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      widget.updatePageState(_foodList);
                      widget.navigatePageStateBackward();
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('Home Page'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue[200],
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
  final int listnumber;

  const FoodItemCard({
    @required this.foodItem,
    @required this.updateFoodItemState,
    @required this.listnumber,
    this.recipeMap,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        //height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Text("Food Item Number " + listnumber.toString()),
            FormQuestion(
              questionText: "What did you eat today?",
              hint: "",
              onSaved: (answer) {
                foodItem.testing = answer;
                var widget;
                widget.updatePageState(foodItem);
              },
              enabled: enabled,
            ),
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
              noItemsFoundBuilder: (BuildContext ctx) {
                return TextButton(
                  child: Text("No Recipes Found! Click to create a new recipe"),
                  onPressed: () =>
                      Navigator.pushNamed(ctx, UIData.NewRecipeRoute),
                  //Push a named route onto the navigator that most tightly encloses the given context.
                );
              },
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
            ElevatedButton(
                    child: const Text('Remove Item'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 4,
                        onSurface: Colors.blueGrey),
                    onPressed: () {
                      //can be toggled to a different colour, but needs to create state. Look at delete toggle for more reference
                    }),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
