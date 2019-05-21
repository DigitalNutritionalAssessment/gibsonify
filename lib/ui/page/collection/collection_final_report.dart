import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';

import 'package:flutter_uikit/model/consumption_data.dart';

import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/ui/page/collection/collection_info_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_first_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_second_page.dart';

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
      InfoDataCard(
        navigatePageState: () {},
        updatePageState: (interviewData) => {},
        initialInterviewData: widget.consumptionData.interviewData,
        enabled: false,
      ),
    ];
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
                pickDateTime: true,
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
            RaisedButton(
              child: const Text('Back To Edit'),
              color: Theme
                  .of(context)
                  .accentColor,
              elevation: 4.0,
              splashColor: Colors.blueGrey,
              onPressed: () {
                widget.navigatePageStateBackToInfo();
              },
            ),
            RaisedButton(
              child: const Text('Submit'),
              color: Theme
                  .of(context)
                  .accentColor,
              elevation: 4.0,
              splashColor: Colors.blueGrey,
              onPressed: () {
                final form = _formKey.currentState;
                if (form.validate()) {
                   _formKey.currentState.save();
                   widget.updatePageState(widget.consumptionData);
                   widget.navigatePageStateSubmit();
                   widget.consumptionData.save();
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
        ...firstPassList,
        ...secondPassList,
        ...endInterviewDataCardList,
        ...buttonsList,

      ],
    );
  }
}

