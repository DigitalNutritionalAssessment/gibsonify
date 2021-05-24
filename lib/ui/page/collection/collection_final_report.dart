import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/ui/page/collection/collection_sensitisation_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_first_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_second_page.dart';
import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';


class FinalReportCard extends StatefulWidget {

  final ConsumptionData consumptionData;
  final VoidCallback navigatePageStateSubmit;
  final VoidCallback navigatePageStateBackToInfo;
  final ValueChanged<ConsumptionData> updatePageState;

  const FinalReportCard ({
    @required this.navigatePageStateSubmit,
    @required this.navigatePageStateBackToInfo,
    @required this.consumptionData,
    @required this.updatePageState,
  });

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
          updateFoodItemState: (item){},
          enabled: false,
        )
    );
    // ignore: unused_local_variable
    List<Widget> firstPassList = new List<Widget>.generate(
        widget.consumptionData.listOfFoods.length,
            (index) =>
            FoodItemCard(
              updateFoodItemState: (foodItem) {
                widget.consumptionData.listOfFoods[index] = foodItem;
              },
              foodItem: widget.consumptionData.listOfFoods[index],
              enabled: false,
            )
    );
    // ignore: unused_local_variable
    List<Widget> secondPassList = new List<Widget>.generate(
        widget.consumptionData.listOfFoods.length,
            (index) =>
            SecondPassFoodItemCard(
              updateFoodItemState: (foodItem) {
                widget.consumptionData.listOfFoods[index] = foodItem;
              },
              foodItem: widget.consumptionData.listOfFoods[index],
              enabled: false,
            )
    );

    List<Widget> endInterviewDataCardList = [
      Card(
        elevation: 2.0,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TimePicker(
                initialTime: widget.consumptionData.interviewData?.interviewEnd ?? null,
                onChanged: (time) {
                  widget.consumptionData.interviewData.interviewEnd = time;
                  widget.updatePageState(widget.consumptionData);
                },
                questionText: "Interview End Time",
                timePickerType: TimePickerType.DATETIME,
              ),
              DialogPicker(
                questionText: "Final Outcome of Interview",
                optionsList: FormStrings.interviewOutcomeSelection.values.toList(),
                onConfirm: (List<int> values) {
                  widget.consumptionData.interviewData.interviewOutcome = InterviewOutcomeSelection.values[values[0]];
                  widget.updatePageState(widget.consumptionData);
                },
              ),
              FormQuestion(
                questionText: "Reasons for Incomplete Interview",
                hint:"",
                initialText:widget.consumptionData.interviewData?.incompleteInterviewReason ?? null,
                onSaved: (answer) {
                  widget.consumptionData.interviewData.incompleteInterviewReason = answer;
                  widget.updatePageState(widget.consumptionData);
                },
              ),
            ],
          ),
        ),
      )
    ];
    List<Widget> buttonsList = [
      new SizedBox(
        height: 70,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton( //RaisdedButton
              child: const Text('Back To Edit'),
              //color: Theme
                //  .of(context)
                //  .accentColor,
              // elevation: 4.0,
              //splashColor: Colors.blueGrey,
              onPressed: () {
                widget.navigatePageStateBackToInfo();
              },
            ),
            ElevatedButton( //RaisedButton
              child: const Text('Submit'),
              //color: Theme
                //  .of(context)
                  //.accentColor,
              //elevation: 4.0,
              //splashColor: Colors.blueGrey,
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

                FoodItem selectedRecipe = recipeMap[selected]?? FoodItem();

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
              optionsList: FormStrings.sourceOfFoodOutcomeSelection.values
                  .toList(),
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
              updateFoodItemState: ()=>{},
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



