import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/ui/decorations.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/ui/page/collection/collection_sensitisation_page.dart';
//import 'package:flutter_uikit/ui/page/collection/collection_first_page.dart';
//import 'package:flutter_uikit/ui/page/collection/collection_second_page.dart';
import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';

class FinalReportCard extends StatefulWidget {
  final ConsumptionData consumptionData;
  final VoidCallback navigatePageStateSubmit;
  final VoidCallback navigatePageStateBackToInfo;
  final VoidCallback navigatePageStateBack;
  final ValueChanged<ConsumptionData> updatePageState;

  const FinalReportCard({
    @required this.navigatePageStateSubmit,
    @required this.navigatePageStateBackToInfo,
    @required this.navigatePageStateBack,
    @required this.consumptionData,
    @required this.updatePageState,
  });

  //Alert
  //it is intendended that this alert dialog goes directly to the submit
  //however, this is put to a separate button for now as we do not want this to pop up every time the recipe is modified
  //also 
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("Close"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    //this is the fourth pass prompt
    AlertDialog alert = AlertDialog(
      title: Text("Help"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        height: 300,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              new Text('This pass is to check all of the items'),
              new ListTile(
                leading: new MyBullet(),
                title: new Text(
                    'Have you checked the foods consumed with the picture chart?'),
              ),
              new ListTile(
                leading: new MyBullet(),
                title: new Text(
                    'Have you cross checked all the foods consumed verbally with the participant?'),
              ),
              new Text(
                  '\nIf you have done so, please press the submit button. If you have not done so, please click the back to edit button'),
            ],
          ),
        ),
      ),
      actions: [
        continueButton,
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
  _FinalReportCardState createState() => _FinalReportCardState();
}

class _FinalReportCardState extends State<FinalReportCard> {
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> infoCardList = [
      SensitisationVisitDataCard(
        navigatePageStateForward: () {},
        navigatePageStateSubmit: () {},
        updatePageState: (interviewData) => {},
        initialInterviewData: widget.consumptionData.interviewData,
        enabled: false,
      ),
    ];
    List<Widget> overallFoodItemCardList = new List<Widget>.generate(
        widget.consumptionData.listOfFoods.length,
        (index) => OverallFoodItemCard(
              foodItem: widget.consumptionData.listOfFoods[index],
              updateFoodItemState: (item) {},
              enabled: false,
            ));

    // this section shows the individual passes in the fourth pass so it could be easily edited
    // this is not necessary as the overall Food Item Card should show everything already, 
    // or at least it will be a drop down 
            
    // List<Widget> firstPassList = new List<Widget>.generate(
    //     widget.consumptionData.listOfFoods.length,
    //     (index) => FoodItemCard(
    //           listnumber: null,
    //           updateFoodItemState: (foodItem) {
    //             widget.consumptionData.listOfFoods[index] = foodItem;
    //           },
    //           foodItem: widget.consumptionData.listOfFoods[index],
    //           enabled: false,
    //         ));
    // List<Widget> secondPassList = new List<Widget>.generate(
    //     widget.consumptionData.listOfFoods.length,
    //     (index) => SecondPassFoodItemCard(
    //           updateFoodItemState: (foodItem) {
    //             widget.consumptionData.listOfFoods[index] = foodItem;
    //           },
    //           foodItem: widget.consumptionData.listOfFoods[index],
    //           enabled: false,
    //         ));
            
    // extra final questions in the fourth pass
    List<Widget> endInterviewDataCardList = [
      Card(
        elevation: 2.0,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TimePicker(
                initialTime:
                    widget.consumptionData.interviewData?.interviewEnd ?? null,
                onChanged: (time) {
                  widget.consumptionData.interviewData.interviewEnd = time;
                  widget.updatePageState(widget.consumptionData);
                },
                questionText: "Interview End Time",
                timePickerType: TimePickerType.DATETIME,
              ),
              DialogPicker(
                questionText: "Final Outcome of Interview",
                optionsList:
                    FormStrings.interviewOutcomeSelection.values.toList(),
                onConfirm: (List<int> values) {
                  widget.consumptionData.interviewData.interviewOutcome =
                      InterviewOutcomeSelection.values[values[0]];
                  widget.updatePageState(widget.consumptionData);
                },
              ),
              FormQuestion(
                questionText: "Reasons for Incomplete Interview",
                hint: "",
                initialText: widget.consumptionData.interviewData
                        ?.incompleteInterviewReason ??
                    null,
                onSaved: (answer) {
                  widget.consumptionData.interviewData
                      .incompleteInterviewReason = answer;
                  widget.updatePageState(widget.consumptionData);
                },
              ),
            ],
          ),
        ),
      )
    ];
    //Can have navigation bar and just have the submit button
    List<Widget> buttonsList = [
      new FittedBox(
        //height: 70,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Back To Edit'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  elevation: 4.0,
                  onSurface: Colors.blueGrey),
              onPressed: () {
                widget.navigatePageStateBackToInfo();
              },
            ),
            ElevatedButton(
              child: const Text('Third Pass'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  elevation: 4.0,
                  onSurface: Colors.blueGrey),
              onPressed: () {
                widget.navigatePageStateBack();
              },
            ),
            ElevatedButton(
              //RaisdedButton
              child: const Text('Prompt'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange[500],
                  elevation: 4.0,
                  onSurface: Colors.blueGrey),
              onPressed: () {
                widget.showAlertDialog(context);
              },
            ),
            ElevatedButton(
              //RaisedButton
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  elevation: 4.0,
                  onSurface: Colors.blueGrey),
              onPressed: () async {
                final form = _formKey.currentState;
                if (form.validate()) {
                  _formKey.currentState.save();
                  widget.updatePageState(widget.consumptionData);
                  widget.navigatePageStateSubmit();
                  widget.consumptionData.save();
                  print(await IcrisatDB().getNextModifiedRecipeID());
                }
              },
            ),
          ],
        ),
      ),
    ];
    return ListView(
      children: [
        ...infoCardList,
        ...overallFoodItemCardList,
//        ...firstPassList,
//        ...secondPassList,
        ...endInterviewDataCardList,
        ...buttonsList,
      ],
    );
  }
}

class OverallFoodItemCard extends StatelessWidget {
  final FoodItem foodItem;
  final updateFoodItemState;
  final bool enabled;
  final Map<String, FoodItem> recipeMap;

  const OverallFoodItemCard({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoCompleteTextField(
              suggestions: recipeMap?.keys?.toList() ?? [],
              onSuggestionSelected: (String selected) {
                foodItem.foodName = selected;

                FoodItem selectedRecipe = recipeMap[selected] ?? FoodItem();

                foodItem.recipe = selectedRecipe.recipe;
                foodItem.ingredientItems = selectedRecipe.ingredientItems;
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
              initialSelectedOption: foodItem?.timeOfDay?.index ?? 0,
              enabled: enabled,
            ),
            DialogPicker(
              questionText: "Source of Food",
              optionsList:
                  FormStrings.sourceOfFoodOutcomeSelection.values.toList(),
              onConfirm: (List<int> values) {
                foodItem.foodSource = SourceOfFoodSelection.values[values[0]];
                updateFoodItemState(foodItem);
              },
              enabled: enabled,
            ),
            Padding(
              padding: const EdgeInsets.all(UIData.collection_edge_inset),
              child: Text(
                "List of Ingredients in recipe",
                style: UIData.smallTextStyle_GreyedOut,
              ),
            ),
            RecipeExpansionTile(
              foodItem: foodItem,
              updateFoodItemState: () => {},
              enabled: false,
              initiallyExpanded: false,
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
