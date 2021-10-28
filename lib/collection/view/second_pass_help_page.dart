import 'package:flutter/material.dart';

class SecondPassHelpPage extends StatelessWidget {
  const SecondPassHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Second Pass Help')),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: refactor into something nicer
            child: Text(
                'Please choose the source of food, and form when eaten, '
                'and fill in a detailed description of each food item consumed.\n\n'
                'Use the probe list below to ask the respondent for more information.\n\n'),
            // TODO: add probe list, maybe add search, or perhaps make the probe
            // questions automatic in second pass screen based on the chosen food
          ),
        ]));
  }
}
