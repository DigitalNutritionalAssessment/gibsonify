import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_uikit/utils/uidata.dart';
//import 'package:flutter_uikit/utils/form_strings.dart';

//import 'package:flutter_uikit/ui/widgets/collection_question.dart';

import 'package:flutter_uikit/model/food_item.dart';

//import 'package:flutter_uikit/database/icrisat_database.dart';

//import 'package:flutter_uikit/ui/page/collection/recipes_items.dart';

class ProbeList extends StatefulWidget {
  //final navigatePageState;
  final navigatePageStateForward;
  final navigatePageStateBack;
  final navigateHome;
  final updatePageState;
  final initialFoodList;
  final Map<String, FoodItem> recipeMap;
  final Map<String, int> fctMap;
  final Map<String, int> rCodeMap;

  const ProbeList({
    //@required this.navigatePageState,
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

  @override
  _ProbeListState createState() => _ProbeListState();
}

class _ProbeListState extends State<ProbeList> {
  @override
  Widget build(BuildContext context) {
    return new Column(
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
      ],
    );
  }
}
