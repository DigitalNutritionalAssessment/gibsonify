import 'package:flutter/material.dart';

class SensitizationHelpPage extends StatelessWidget {
  const SensitizationHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sensitization Help')),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: refactor into something nicer
            child: Text('Please explain the survey to the respondent(s)'
                '/participants and what is expected from them.'
                '\n\n'
                'Afterwards, schedule an appointment for '
                'the interview the day after today.'
                '\n\n'
                'Lastly, hand over the food picture chart to the respondent(s) '
                'and guide them how to record responses in the chart '
                'on the recall day.'),
          ),
        ]));
  }
}
