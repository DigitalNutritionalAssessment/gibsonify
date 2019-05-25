import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter/services.dart';


import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/utils/form_strings.dart';

class InfoDataCard extends StatefulWidget {

  final InterviewData initialInterviewData;
  final navigatePageState;
  final ValueChanged<InterviewData> updatePageState;
  final bool enabled;

  const InfoDataCard ({
    @required this.navigatePageState,
    @required this.updatePageState,
    this.initialInterviewData,
    this.enabled,
  });

  @override
  _InfoDataCardState createState() => _InfoDataCardState();
}

class _InfoDataCardState extends State<InfoDataCard> {

  InterviewData interviewData = new InterviewData();
  bool enabled = true;
//  ValueChanged<InterviewData> updatePageState;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    if (widget.initialInterviewData != null) interviewData = widget.initialInterviewData;
    if (widget.enabled != null) enabled = widget.enabled;
//    if (widget.updatePageState != null)   updatePageState = (interviewData)=> {widget.updatePageState(interviewData)};
    getEnumeratorInfo();
    super.initState();
  }

  void getEnumeratorInfo() async{
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    interviewData.enumerator.name = _prefs.getString("userName");
//    interviewData.enumerator.employeeNumber = _prefs.getInt("employeeName");
      Person enumerator = await Person.getEnumeratorFromSharedPrefs();
      interviewData.enumerator = enumerator;
      interviewData.location = await InterviewData.getLocationFromSharedPrefs();

  }



  @override
  Widget build(BuildContext context) {

    final FocusNode _hhFocusNode = FocusNode();
    final FocusNode _respNameFocusNode = FocusNode();
    final FocusNode _respID = FocusNode();
    final FocusNode _respTelNo = FocusNode();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
          elevation: 2.0,
          child: Container(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FormQuestion(
                      questionText: "Household Identification",
                      hint:"(10 characters)",
                      validate: (answer) {
                        if (answer.length > 10){
                          return "10 characters only!";
                        }
                        return emptyFieldValidator(answer);
                      },
                      initialText: interviewData.householdIdentification ?? null,
                      onSaved: (answer) {
                        interviewData.householdIdentification = answer;
                        widget.updatePageState(interviewData);
                        },
                      focusNode: _hhFocusNode,
                      nextFocusNode: _respNameFocusNode,
                      enabled: enabled,
                    ),
                    FormQuestion(
                      questionText: "Respondent Name",
                      hint:"",
                      validate: emptyFieldValidator,
                      initialText: interviewData?.respondent?.name ?? null,
                      onSaved: (answer) {
                        interviewData.respondent.name = answer;
                        widget.updatePageState(interviewData);
                        },
                      focusNode: _respNameFocusNode,
                      nextFocusNode: _respID,
                      enabled: enabled,
                    ),
                    FormQuestion(
                      questionText: "Respondent ID",
                      hint:"",
                      validate: emptyFieldValidator,
                      initialText: interviewData?.respondent?.id?.toString() ?? null,
                      onSaved: (answer) {
                        interviewData.respondent.id = int.tryParse(answer);
                        widget.updatePageState(interviewData);
                      },
                      focusNode: _respID,
                      nextFocusNode: _respTelNo,
                      enabled: enabled,
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]
                    ),
                    FormQuestion(
                      questionText: "Respondent Telephone Number",
                      hint:"",
                      initialText:interviewData?.respondent?.telephone ?? null,
                      validate: emptyFieldValidator,
                      onSaved: (answer) {
                        interviewData.respondent.telephone = answer;
                        widget.updatePageState(interviewData);
                        },
                      focusNode: _respTelNo,
                      enabled: enabled,
                      keyboardType: TextInputType.number,
                    ),
                    TimePicker(
                      initialTime: interviewData?.respondent?.birthDate ?? null,
                      onChanged: (time) {
                        interviewData.respondent.birthDate = time;
                        widget.updatePageState(interviewData);
                      },
                      questionText: "Respondent Birthdate",
                      timePickerType: TimePickerType.DATE,
                    ),
                    TimePicker(
                      initialTime: interviewData?.interviewStart ?? null,
                      onChanged: (time) {
                        interviewData.interviewStart = time;
                        widget.updatePageState(interviewData);
                        },
                      questionText: "Interview Start Time",
                      timePickerType: TimePickerType.DATETIME,
                    ),
                  ],
                )
              ),
            ),
          ),
          (enabled? buttons(): Container()),   // Display the buttons if enabled is true

        ],
      ),
    );
    }

  Widget buttons(){
    return RaisedButton(
      child: const Text('Go to First Pass'),
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      splashColor: Colors.blueGrey,
      onPressed: () {
        final form = _formKey.currentState;
        if (form.validate()) {
          form.save();
          widget.navigatePageState();
          widget.updatePageState(interviewData);
        }
      },
    );
  }
}
