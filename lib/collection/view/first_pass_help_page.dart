// TODO: page_router add route,
// and add floating action button to sensitization scree

import 'package:flutter/material.dart';

class FirstPassHelpPage extends StatelessWidget {
  const FirstPassHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('First Pass Help')),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: refactor into something nicer
            child: Text('Please choose an unambiguous food or dish name.\n\n'
                'Do not specify the state of the food e.g. cooked.\n\n'
                'For each food, choose the time period from the following: morning, afternoon, evening, night.'),
            // TODO: add examples of correct and incorrect foods
          ),
        ]));
  }
}
