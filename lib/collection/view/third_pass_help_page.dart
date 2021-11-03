import 'package:flutter/material.dart';

class ThirdPassHelpPage extends StatelessWidget {
  const ThirdPassHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Third Pass Help')),
        body: Column(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // TODO: refactor into something nicer
            // TODO: make it scrollable to prevent RenderFlex Bottom Overflow
            child: Text(
                'Please start with the first food item recorded in first pass.'
                '\n\n'
                'Ask the mother to bring the plate, cup, bowls, spoons, glasses'
                ' or any other items used to consume and serve foods.\n\n'
                'Refer to the measurement list and choose the best method'
                ' to use.\n\n'
                'Inform the mother and illustrate how you intend to estimate'
                ' the quantity used.\n\n'
                'You will need 2 plates.\n\n'
                'Ask the mother to show you the food exactly as she recalls it'
                ' in size/ shape, quantity or level when she served it'
                ' yesterday on plate 1.\n\n'
                'Ask if all the food served was consumed or if something'
                ' was left in the end.\n\n'
                'If some was left, ask her to take out what was left'
                ' (reduce the amount) and put it on plate 2.\n\n'
                'Ask if there were other servings, and repeat the'
                ' procedure if necessary.\n\n'
                'Clarify to the respondent that you are referring to the'
                ' servings during the same sitting or eating episode.'),
            // TODO:
          ),
        ]));
  }
}
