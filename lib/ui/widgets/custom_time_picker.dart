import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimePicker extends StatefulWidget{

  final ValueChanged<DateTime> onChanged;
  final DateTime initialTime;
  final String questionText;
  final bool pickDateTime;

  const TimePicker({
    Key key,
    @required this.onChanged,
    this.initialTime,
    this.questionText,
    this.pickDateTime,

  }): super(key:key);

  @override
  State createState() => new TimePickerState();
}

class TimePickerState extends State<TimePicker>{

  DateTime _pickedTime = DateTime.now();
  bool pickDateTime = false;
  static Function datePickerFactory;

  @override
  void initState() {
    if (widget.initialTime != null) _pickedTime = widget.initialTime;
    if (widget.pickDateTime != null) pickDateTime = widget.pickDateTime;

    if (pickDateTime) datePickerFactory = DatePicker.showDateTimePicker;
    else datePickerFactory = DatePicker.showTimePicker;

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
              convertDateTimeToString(_pickedTime, pickDateTime),
              textAlign: TextAlign.left,
              style: UIData.smallTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  String convertDateTimeToString(DateTime _datetime, bool pickDateTime){
    if (_datetime == null) return '';
    else {
      String outputString = "";
      if (pickDateTime){
        outputString +=  "${_datetime?.day.toString() ?? '' } / ${_datetime?.month.toString() ?? '' } / ${_datetime?.year.toString() ?? ''}";
      }
      outputString += "\t";
      outputString += "${_datetime?.hour.toString() ?? ''} : ${_datetime?.minute.toString() ?? ''}";
      return outputString;
    }
  }
}