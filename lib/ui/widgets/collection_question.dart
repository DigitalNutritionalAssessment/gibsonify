import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';



class Question extends StatefulWidget {

  final String questionText;
  final String hint;
  final ValueChanged<String> onSubmitted;
  final Function validate;

  const Question({
    Key key,
    @required this.questionText,
    @required this.hint,
    @required this.onSubmitted,
    this.validate,
  }): super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  String answer;                    // Store answer state
  bool _validate = false;
  String validationErrorText = "";
  Function validate;
  Function submit;

  final TextEditingController controller = TextEditingController();
  // Initialise foodNameController and set state to be itemData.foodName if available

  @override
  void initState() {
    if (widget.validate == null) validate = (string) => "";
    controller.addListener(() {
      answer = controller.text;
    });

    submit = (string){
      validationErrorText = validate(answer);
      setState(() {
        (validationErrorText.length > 0) ? _validate = true : _validate = false;
      });
      widget.onSubmitted(string);
    };

    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
          widget.questionText,
          style: UIData.smallTextStyle_GreyedOut
      ),
      TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            errorText: _validate ? validationErrorText : null,
        ),
        style: UIData.smallTextStyle,
        onSubmitted: submit,
      ),
    ],
  );
}
}


class FormQuestion extends StatelessWidget {

  final String questionText;
  final String hint;
  final String initialText;

  final ValueChanged<String> validate;
  final ValueChanged<String> onSaved;

  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  final bool enabled;

  const FormQuestion({
    Key key,
    @required this.questionText,
    @required this.hint,
    this.initialText,
    this.focusNode,
    this.nextFocusNode,
    this.validate,
    this.onSaved,
    this.enabled,
  }):super(key:key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UIData.collection_edge_inset),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        initialValue: initialText,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: questionText,
          labelStyle: UIData.smallTextStyle_GreyedOut,
          hintText: hint,
          prefixStyle: UIData.smallTextStyle_GreyedOut,
          hintStyle: UIData.smallTextStyle_GreyedOut,
        ),
        style: UIData.smallTextStyle,
        autovalidate: true,
        validator: validate,
        onSaved: onSaved,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, focusNode, nextFocusNode);
          onSaved(term);
        },
        enabled: enabled ?? true,
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}


class DialogPicker extends StatefulWidget {

  final ValueChanged<List<int>> onConfirm;
  final List<String> optionsList;
  final String questionText;
  final int initialSelectedOption;
  final bool enabled;

  const DialogPicker({
    Key key,
    @required this.optionsList,
    @required this.onConfirm,
    @required this.questionText,
    this.initialSelectedOption,
    this.enabled,
  }): super(key:key);

  @override
  _DialogPickerState createState() => _DialogPickerState();
}

class _DialogPickerState extends State<DialogPicker> {

  int _currentlySelectedOption = 0;

  bool enabled = true;

  @override
  void initState() {
    // init original time
    if (widget.initialSelectedOption != null) _currentlySelectedOption = widget.initialSelectedOption;
    if (widget.enabled != null) enabled = widget.enabled;

    widget.onConfirm([_currentlySelectedOption]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var onPressed;

    //if enabled, set the buttons to be disabled by setting onPress to be null!
    if (enabled){
      onPressed = () => showPicker(context);
    }
    else{
      onPressed = null;
    }

    return Padding(
      padding: const EdgeInsets.all(UIData.collection_edge_inset),
      child: Column(
        children: <Widget>[
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(0),
            onPressed: onPressed,
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
              widget.optionsList[_currentlySelectedOption],
              textAlign: TextAlign.left,
              style: UIData.smallTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  showPicker(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: widget.optionsList),
      changeToFirst: true,
      textAlign: TextAlign.left,
      hideHeader: true,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker,List values) {
        widget.onConfirm(values);
        setState(() {
          _currentlySelectedOption = values[0];
          print(values[0]);
        });
      },
    ).showDialog(context);
  }
}

class AutoCompleteTextField extends StatefulWidget {

  final List<String> suggestions;
  final ValueChanged<String> onSuggestionSelected;
  final String questionText;
  final String hintText;
  final String initialText;
  final ValueChanged<String> validate;
  final bool enabled;


  const AutoCompleteTextField({
    @required this.suggestions,
    @required this.onSuggestionSelected,
    @required this.questionText,
    this.validate,
    this.hintText,
    this.enabled,
    this.initialText,
  });

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {

  final TextEditingController _typeAheadController = TextEditingController();
  bool enabled = true;

  @override
  void initState() {
    _typeAheadController.text = widget.initialText;
    if (widget.enabled != null) enabled = widget.enabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //if (!((widget.initialText?.length??0) == 0)){
    if (enabled){
      return Padding(
        padding: const EdgeInsets.all(UIData.collection_edge_inset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                widget.questionText??"",
                style: UIData.smallTextStyle_GreyedOut
            ),
            SizedBox(
              height:3,
            ),
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _typeAheadController,
                autofocus: false,
                style: UIData.smallTextStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText ?? "",
                ),
              ),
              suggestionsCallback: (pattern)  {
                return widget.suggestions.where(
                        (item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                _typeAheadController.text = suggestion;
                widget.onSuggestionSelected(suggestion);
              },
              onSaved: (suggestion){
                widget.onSuggestionSelected(suggestion);
              },
              validator: widget.validate ?? ()=>null,
            ),
          ],
        ),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.all(UIData.collection_edge_inset),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  widget.questionText??"",
                  style: UIData.smallTextStyle_GreyedOut,
              ),
              SizedBox(
                height:3,
              ),
              Text(
                widget.initialText??"",
                textAlign: TextAlign.left,
                style: UIData.smallTextStyle,
              ),
            ],
          ),
        ),
      );
    }


  }
}


