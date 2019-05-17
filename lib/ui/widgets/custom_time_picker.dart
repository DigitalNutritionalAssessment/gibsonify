import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class TimePicker extends StatefulWidget{

  final ValueChanged<DateTime> onChanged;
  final ValueChanged<DateTime> onConfirm;
  final DateTime initialTime;

  const TimePicker({
    Key key,
    @required this.onChanged,
    @required this.onConfirm,
    this.initialTime,
  }): super(key:key);

  @override
  State createState() => new TimePickerState();
}

class TimePickerState extends State<TimePicker>{

  DateTime _pickedTime;

  @override
  void initState() {
    if (widget.initialTime == null) _pickedTime = widget.initialTime;
    else _pickedTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext ctx){
    return Column(
      children: <Widget>[
        FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.all(0),
          onPressed: () {
            DatePicker.showTimePicker(context,
                showTitleActions: true,
                onChanged: (time) {
                  widget.onChanged(time);
                  setState(() {
                    _pickedTime = time;
                  });
                }, onConfirm: (time) {
                  widget.onConfirm(time);
                  setState(() {
                    _pickedTime = time;
                  });
                }, currentTime: DateTime.now());
          },
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'What time did you eat it?',
              textAlign: TextAlign.left,
              style:  UIData.smallTextStyle_Bold,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            convertDateTimeToString(_pickedTime),
            textAlign: TextAlign.left,
            style: UIData.smallTextStyle,
          ),
        ),
      ],
    );
  }

  String convertDateTimeToString(DateTime _datetime){
    if (_datetime == null) return '';
    else return "${_datetime?.hour.toString() ?? ''} : ${_datetime?.minute.toString() ?? ''}";
  }
}