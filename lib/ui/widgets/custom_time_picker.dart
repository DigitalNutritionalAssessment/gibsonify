import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

enum TimePickerType{
  DATE,
  TIME,
  DATETIME,
}


class TimePicker extends StatefulWidget{

  final ValueChanged<DateTime> onChanged;
  final DateTime initialTime;
  final String questionText;
  final TimePickerType timePickerType;

  const TimePicker({
    Key key,
    @required this.onChanged,
    this.initialTime,
    this.questionText,
    this.timePickerType,

  }): super(key:key);

  @override
  State createState() => new TimePickerState();
}

class TimePickerState extends State<TimePicker>{

  DateTime _pickedTime = DateTime.now();
  TimePickerType timePickerType = TimePickerType.TIME; // Default to time
  Function datePickerFactory;

  @override
  void initState() {
    if (widget.initialTime != null) _pickedTime = widget.initialTime;
    if (widget.timePickerType != null) timePickerType = widget.timePickerType;

    if (timePickerType == TimePickerType.DATETIME) datePickerFactory = DatePicker.showDateTimePicker;
    else if (timePickerType == TimePickerType.DATE) datePickerFactory = DatePicker.showDatePicker;
    else datePickerFactory = DatePicker.showTimePicker;

    print(timePickerType.toString());

    // use this to initialise the form state
    widget.onChanged(_pickedTime);

    super.initState();
  }

  @override
  Widget build(BuildContext ctx){

    return Padding(
      padding: const EdgeInsets.all(UIData.collection_edge_inset),
      child: Column(
        children: <Widget>[
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(0),
            onPressed: () {
              datePickerFactory(context,
                  showTitleActions: true,
                  onChanged: (time) {
                    widget.onChanged(time);
                    setState(() {
                      _pickedTime = time;
                    });
                  }, currentTime: _pickedTime);
              return ;
            },
            child: SizedBox(
              width: double.infinity,
              child: Text(
                widget.questionText,
                textAlign: TextAlign.left,
                style:  UIData.smallTextStyle_GreyedOut,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              convertDateTimeToString(_pickedTime, timePickerType),
              textAlign: TextAlign.left,
              style: UIData.smallTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  String convertDateTimeToString(DateTime _datetime, TimePickerType timePickerType){
    if (_datetime == null) return '';
    else {
      String outputString = "";
      if (timePickerType == TimePickerType.DATE || timePickerType == TimePickerType.DATETIME){
        outputString +=  "${_datetime?.day.toString() ?? '' } / ${_datetime?.month.toString() ?? '' } / ${_datetime?.year.toString() ?? ''}";
      }
      if (timePickerType == TimePickerType.TIME || timePickerType == TimePickerType.DATETIME) {
        outputString += "\t";
        outputString +=
        "${_datetime?.hour.toString() ?? ''} : ${_datetime?.minute.toString() ??
            ''}";
      }
      return outputString;
    }
  }
}