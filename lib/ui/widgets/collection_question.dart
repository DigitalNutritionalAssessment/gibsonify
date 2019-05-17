import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';


class Question extends StatefulWidget {

  final String questionText;
  final String hint;
  final ValueChanged<String> onSubmitted;

  const Question({
    Key key,
    @required this.questionText,
    @required this.hint,
    @required this.onSubmitted,
  }): super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  String answer;                    // Store answer state

  TextEditingController controller = TextEditingController();
  // Initialise foodNameController and set state to be itemData.foodName if available

  @override
  void initState() {
    controller.addListener(() {
      answer = controller.text;
    });
    super.initState();
  }

@override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
          widget.questionText,
          style: UIData.smallTextStyle_Bold
      ),
      TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint
        ),
        style: UIData.smallTextStyle,
        onSubmitted: widget.onSubmitted,
      ),
    ],
  );
}
}










