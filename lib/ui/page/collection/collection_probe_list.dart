import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter_uikit/utils/uidata.dart';
//import 'package:flutter_uikit/utils/form_strings.dart';

//import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';

//import 'package:flutter_uikit/database/icrisat_database.dart';

//import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';

//import 'package:flutter/material.dart';

/*
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
    //this.rCodeMap, Null Function() navigatePageStateBack, Null Function() navigatePageStateForward,
  });
  createState() => _ProbeListState();
}


//trying of slide to delete
List<String> listItems = [
  "Hello",
  "World",
  "Flutter",
  "Love"
]; //Probe List

class _ProbeListState extends State<ProbeList> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Container(
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
            ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(listItems[index]),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(listItems[index]),
                  ),
                  onDismissed: (direction) {
                    var item = listItems.elementAt(index);
                    //To delete
                    deleteItem(index);
                    //To show a snackbar with the UNDO button
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Question has been asked"),
                        action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () {
                              //To undo deletion
                              undoDeletion(index, item);
                            })));
                  },
                );
              },
            ),
          ]),
        )));
  }

  void deleteItem(index) {
    /*
    By implementing this method, it ensures that upon being dismissed from our widget tree, 
    the item is removed from our list of items and our list is updated, hence
    preventing the "Dismissed widget still in widget tree error" when we reload.
    */
    setState(() {
      listItems.removeAt(index);
    });
  }

  void undoDeletion(index, item) {
    /*
    This method accepts the parameters index and item and re-inserts the {item} at
    index {index}
    */
    setState(() {
      listItems.insert(index, item);
    });
  }


  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.pink[900],
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
  
}
*/

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
    //this.rCodeMap, Null Function() navigatePageStateBack, Null Function() navigatePageStateForward,
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
      title: Text("AlertDialog"),
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
