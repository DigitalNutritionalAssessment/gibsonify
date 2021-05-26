import 'package:flutter/material.dart';
//import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter/services.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/utils/form_strings.dart';

class SensitisationVisitDataCard extends StatefulWidget {
  final InterviewData initialInterviewData;
  final VoidCallback navigatePageStateForward;
  final VoidCallback navigatePageStateSubmit;
  final VoidCallback saveConsumptionData;
  final ValueChanged<InterviewData> updatePageState;
  final bool enabled;

  const SensitisationVisitDataCard({
    @required this.navigatePageStateForward,
    @required this.navigatePageStateSubmit,
    @required this.updatePageState,
    this.saveConsumptionData,
    this.initialInterviewData,
    this.enabled,
  });

  @override
  _SensitisationVisitDataCardState createState() =>
      _SensitisationVisitDataCardState();
}

class _SensitisationVisitDataCardState
    extends State<SensitisationVisitDataCard> {
  InterviewData interviewData = new InterviewData(
    sensitizationVisitDate: DateTime.now(),
    respondent: Person(birthDate: DateTime.now()),
  );
  bool enabled = true;
//  ValueChanged<InterviewData> updatePageState;
  final _formKey = GlobalKey<FormState>();
  VoidCallback saveConsumptionData = () => {};

  @override
  void initState() {
    if (widget.initialInterviewData != null)
      interviewData = widget.initialInterviewData;
    if (widget.enabled != null) enabled = widget.enabled;
    if (widget.saveConsumptionData != null)
      saveConsumptionData = widget.saveConsumptionData;

    getEnumeratorInfo();
    super.initState();
  }

  void getEnumeratorInfo() async {
//    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    interviewData.enumerator.name = _prefs.getString("userName");
//    interviewData.enumerator.employeeNumber = _prefs.getInt("employeeName");
    Person enumerator = await Person.getEnumeratorFromSharedPrefs();
    interviewData.enumerator = enumerator;
    interviewData.location.locationName =
        await InterviewData.getLocationFromSharedPrefs();
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
                        hint: "(10 characters)",
                        validate: (answer) {
                          if (answer.length > 10) {
                            return "10 characters only!";
                          }
                          return emptyFieldValidator(answer);
                        },
                        initialText:
                            interviewData.householdIdentification ?? null,
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
                        hint: "",
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
                          hint: "",
                          validate: (answer) {
                            if (answer.length > 4) {
                              return "Must be between 2-4 characters";
                            }
                            if (answer.length < 2) {
                              return "Must be between 2-4 characters";
                            }
                            return emptyFieldValidator(answer);
                          },
                          initialText:
                              interviewData?.respondent?.id?.toString() ?? null,
                          onSaved: (answer) {
                            interviewData.respondent.id = int.tryParse(answer);
                            widget.updatePageState(interviewData);
                          },
                          focusNode: _respID,
                          nextFocusNode: _respTelNo,
                          enabled: enabled,
                          keyboardType: TextInputType.number,
                          // ignore: deprecated_member_use
                          inputFormatters: [
                            // ignore: deprecated_member_use
                            WhitelistingTextInputFormatter.digitsOnly
                          ]),
                      FormQuestion(
                          //in future can be modified to give phone input widget
                          questionText: "Respondent Telephone Number",
                          hint: "",
                          initialText:
                              interviewData?.respondent?.telephone ?? null,
                          validate: (answer) {
                            if (answer.length != 10) {
                              return "Please enter a valid phone number";
                              //Indian phone numbers are in the form of (+91) then ten digits
                            }
                            return emptyFieldValidator(answer);
                          },
                          onSaved: (answer) {
                            interviewData.respondent.telephone = answer;
                            widget.updatePageState(interviewData);
                          },
                          focusNode: _respTelNo,
                          enabled: enabled,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            // ignore: deprecated_member_use
                            WhitelistingTextInputFormatter.digitsOnly
                          ]),
                      TimePicker(
                        initialTime:
                            interviewData?.respondent?.birthDate ?? null,
                        onChanged: (time) {
                          interviewData.respondent.birthDate = time;
                          widget.updatePageState(interviewData);
                        },
                        questionText: "Respondent Birthdate",
                        timePickerType: TimePickerType.DATE,
                      ),
//                    TimePicker(
//                      initialTime: interviewData?.interviewStart ?? null,
//                      onChanged: (time) {
//                        interviewData.interviewStart = time;
//                        widget.updatePageState(interviewData);
//                        },
//                      questionText: "Interview Start Time",
//                      timePickerType: TimePickerType.DATETIME,
//                    ),
                      TimePicker(
                        initialTime:
                            interviewData?.sensitizationVisitDate ?? null,
                        onChanged: (time) {
                          interviewData.sensitizationVisitDate = time;
                          widget.updatePageState(interviewData);
                        },
                        questionText: "Sensitization Visit Date",
                        timePickerType: TimePickerType.DATE,
                      ),
                    ],
                  )),
            ),
          ),
          (enabled
              ? buttons()
              : Container()), // Display the buttons if enabled is true
        ],
      ),
    );
  }

  Widget buttons() {
    return new FittedBox(
      fit: BoxFit.contain,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Start Interview'),
            //color: Theme.of(context).accentColor,
            //elevation: 4.0,
            //splashColor: Colors.blueGrey,
            onPressed: () {
              widget.updatePageState(interviewData);
              widget.navigatePageStateForward();
            },
          ),
          ElevatedButton(
            child: const Text('Save Sensitisation Info'),
            //color: Theme.of(context).accentColor,
            //elevation: 4.0,
            //splashColor: Colors.blueGrey,
            onPressed: () {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                widget.updatePageState(interviewData);
                saveConsumptionData();
                widget.navigatePageStateSubmit();
              }
            },
          ),
        ],
      ),
    );

//      RaisedButton(
//      child: const Text('Go to First Pass'),
//      color: Theme.of(context).accentColor,
//      elevation: 4.0,
//      splashColor: Colors.blueGrey,
//      onPressed: () {
//        final form = _formKey.currentState;
//        if (form.validate()) {
//          form.save();
//          widget.navigatePageState();
//          widget.updatePageState(interviewData);
//        }
//      },
//    );
  }
}
