import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/food_item.dart';

class ProbeList extends StatefulWidget {
  final navigatePageStateForward;
  final navigatePageStateBack;
  final navigateHome;
  final updatePageState;
  final initialFoodList;
  final Map<String, FoodItem> recipeMap;
  final Map<String, int> fctMap;
  final Map<String, int> rCodeMap;

  const ProbeList({
    @required this.navigatePageStateForward,
    @required this.navigatePageStateBack,
    @required this.updatePageState,
    @required this.navigateHome,
    this.recipeMap,
    this.initialFoodList,
    this.fctMap,
    this.rCodeMap,
  });

  
  //Alert
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No, Back to Probe List"),
      onPressed:  () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: Text("Yes, Continue to Third Pass"),
      onPressed:  () {
        navigatePageStateForward();
        Navigator.pop(context);
      },
    );
  

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Reminder"),
      content: Text("Have you checked all the boxes required?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  _ProbeListState createState() => _ProbeListState();
}

class _ProbeListState extends State<ProbeList> {

/*
  List<String> _probequestions = ['Did you add milk?','Which one?'];

  Map<String, bool> values = {
    for (var i=0; i< _probequestions.length; i++){
      _probequestions[i]: false,
    }
*/ //This bit is left to create an extendable list that can be inputted, use in the future

  Map<String, bool> values = {
    'Did you add milk?': false,
    'Which one?': false,
    'Did you add sugar?' : false,
    'Did you add anything else?' : false,
  };

  //worked on user interface, but did not match the recipes to the specific probe lists. 
  //Probe list should be designed as an editable list that could convert to strings

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(4),
              child: ElevatedButton(
                  child: const Text('Second Pass'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () {
                    widget.navigatePageStateBack();
                  })), //button first

          Container(
              margin: EdgeInsets.all(4),
              child: ElevatedButton(
                child: const Text('Home Page'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  widget.navigateHome();
                },
              )), // button second

          Container(
            margin: EdgeInsets.all(4),
            child: ElevatedButton(
              child: const Text('Third Pass'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  elevation: 4,
                  onSurface: Colors.blueGrey),
              onPressed: () {
                widget.showAlertDialog(context);
              },
            ),
          ) // button third

          // Add more buttons here
        ],
      ),





/*
Scaffold(
  floatingActionButton: Wrap( //will break to another line on overflow
    direction: Axis.horizontal, //use vertical to show  on vertical axis
    children: <Widget>[
          Container( 
            margin:EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: (){
                  //action code for button 1
              },
              child: Icon(Icons.add),
            )
          ), //button first

          Container( 
            margin:EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: (){
                  //action code for button 2
              },
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.add),
            )
          ), // button second

          Container(
            margin:EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: (){
                  //action code for button 3
              },
              backgroundColor: Colors.deepOrangeAccent,
              child: Icon(Icons.add),
            )
          ), // button third

          // Add more buttons here
    ],),
)
*/

      /*
      children: <Widget>[
        Text('No idea what is going on'),
        
        
        new FittedBox(
          fit: BoxFit.contain,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  child: const Text('Go to First Pass'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      elevation: 4,
                      onSurface: Colors.blueGrey),
                  onPressed: () {
                    widget.navigatePageStateBack();
                  }),
              ElevatedButton(
                child: const Text('Home Page'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  widget.navigateHome();
                },
              ),
              ElevatedButton(
                child: const Text('Go to Third Pass'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    elevation: 4,
                    onSurface: Colors.blueGrey),
                onPressed: () {
                  widget.navigatePageStateForward();
                },
              ),
            ],
          ),
        ),
      ],*/
    );
  }
}
