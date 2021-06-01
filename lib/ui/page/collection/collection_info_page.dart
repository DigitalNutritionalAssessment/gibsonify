import 'package:flutter/material.dart';
//import 'package:flutter_uikit/utils/uidata.dart';
import 'package:location/location.dart';

import 'package:flutter/services.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';
import 'package:flutter_uikit/ui/widgets/custom_time_picker.dart';

import 'package:flutter_uikit/utils/form_strings.dart';

//this page is the interview data page

class InfoDataCard extends StatefulWidget {
  final InterviewData initialInterviewData;
  final VoidCallback navigatePageStateForward;
  final VoidCallback navigatePageStateBackward;
  final ValueChanged<InterviewData> updatePageState;
  final bool enabled;

  const InfoDataCard({
    @required this.navigatePageStateForward,
    @required this.navigatePageStateBackward,
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
  void initState() {
    if (widget.initialInterviewData != null)
      interviewData = widget.initialInterviewData;
    if (widget.enabled != null) enabled = widget.enabled;

    // Get Location Data if there is no current lat AND log data.
    if (interviewData.location.latitude == null &&
        interviewData.location.longitude == null) {
      getLocData();
    }

    super.initState();
  }

  Future getLocData() async {
    LocationData currentLocation;

    var location = new Location();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      currentLocation = null;
    }
    interviewData.location.latitude = currentLocation.latitude;
    interviewData.location.longitude = currentLocation.longitude;
    interviewData.location.accuracy = currentLocation.accuracy;

    print(interviewData.location.latitude);
    print(interviewData.location.longitude);
  }

  Future<void> getDayCode(int dayCode) async {
    //function which rebuilds page when Day Code changed
    int _code = await dayCode;
<<<<<<< HEAD
=======
    //ignore error above
>>>>>>> week3_features
    print('DayCode updated to ${DayCode.values[_code]}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final FocusNode _hhFocusNode = FocusNode();
    // ignore: unused_local_variable
    final FocusNode _respNameFocusNode = FocusNode();
    // ignore: unused_local_variable
    final FocusNode _respID = FocusNode();
    // ignore: unused_local_variable
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
                    TimePicker(
                      initialTime: interviewData?.recallDate ?? null,
                      onChanged: (time) {
                        interviewData.recallDate = time;
                        widget.updatePageState(interviewData);
                      },
                      questionText: "Recall Date",
                      timePickerType: TimePickerType.DATE,
                    ),
                    DialogPicker(
                      questionText:
                          "Recall Day Code (What kind of day was it?)",
                      optionsList: FormStrings.dayCodeSelection.values.toList(),
                      onConfirm: (List<int> values) {
                        interviewData.dayCode = DayCode.values[values[0]];
                        widget.updatePageState(interviewData);
                        getDayCode(interviewData.dayCode.index);
                      },
                      initialSelectedOption: 0,
                    ),
                    FormQuestion(
                      questionText: "If other, please specify",
                      hint: "",
                      //validate so only applies if other is selected above, not working
                      validate: (answer) {
                        if (interviewData.dayCode == DayCode.OTHERS) {
                          return emptyFieldValidator(answer);
                        } else {
                          if (answer.length > 0) {
                            return 'Field should be blank';
                          } else {
                            return null;
                          }
                        }
                      },
                      onSaved: (answer) {
                        interviewData.dayCodeOther = answer;
                        widget.updatePageState(interviewData);
                      },
                      enabled: true,
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
                    FormQuestion(
                      questionText: "Current Location Coordinates",
                      //ternary operator, will display to 2dp if latitude is available, will show null if not
                      hint: ((interviewData.location.latitude == null)
                          ? ("${interviewData.location.locationName}: (${interviewData.location.latitude},${interviewData.location.longitude})")
                          : ("${interviewData.location.locationName}: (${interviewData.location.latitude.toStringAsFixed(2)},${interviewData.location.longitude.toStringAsFixed(2)})")),
                      initialText: ((interviewData.location.latitude == null)
                          ? ("${interviewData.location.locationName}: (${interviewData.location.latitude},${interviewData.location.longitude})")
                          : ("${interviewData.location.locationName}: (${interviewData.location.latitude.toStringAsFixed(2)},${interviewData.location.longitude.toStringAsFixed(2)})")),
                      enabled: false,
                    )
                  ],
                ),
              ),
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
            child: const Text('View Interview Info'),
            //color: Theme.of(context).accentColor,
            //elevation: 4.0,
            //splashColor: Colors.blueGrey,
            onPressed: () {
              widget.updatePageState(interviewData);
              widget.navigatePageStateBackward();
            },
          ),
          ElevatedButton(
            child: const Text('Go To First Pass'),
            //color: Theme.of(context).accentColor,
            //elevation: 4.0,
            //splashColor: Colors.blueGrey,
            onPressed: () {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                widget.updatePageState(interviewData);
                widget.navigatePageStateForward();
              }
            },
          ),
        ],
      ),
    );
  }
}
