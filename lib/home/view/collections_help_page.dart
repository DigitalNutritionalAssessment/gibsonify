import 'package:flutter/material.dart';

class CollectionsHelpPage extends StatelessWidget {
  const CollectionsHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Collections Help')),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: refactor into something nicer
            child: Text('Collections page shows all collected forms of all '
                'participants, along with the name of each participant, '
                'the date of their interview, the outcome of the interview, '
                'and also whether the collection is finished or just paused '
                '(in progress).'
                '\n\n'
                'Each collection can be deleted or duplicated by '
                'long-pressing on it.'
                '\n\n'
                'Duplicating a collection creates an identical copy, which '
                'needs to be edited using the correct name of the new '
                'participant, along with their measurements and other values, '
                'which can save time when '
                'collecting forms for multiple members of the same household.'),
          ),
        ]));
  }
}
