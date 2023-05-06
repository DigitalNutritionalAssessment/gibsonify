import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class CollectionStep {
  Icon icon;
  String title;
  String? helpRoute;
  Widget screen;

  CollectionStep(
      {required this.icon,
      required this.title,
      this.helpRoute,
      required this.screen});
}

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key, this.collection}) : super(key: key);

  final GibsonsForm? collection;

  @override
  Widget build(BuildContext context) {
    final List<CollectionStep> screens = [
      CollectionStep(
          icon: const Icon(Icons.info),
          title: 'Sensitization',
          helpRoute: PageRouter.sensitizationHelp,
          screen: const SensitizationScreen()),
      CollectionStep(
          icon: const Icon(Icons.one_k),
          title: 'First Pass',
          helpRoute: PageRouter.firstPassHelp,
          screen: const FirstPassScreen()),
      CollectionStep(
          icon: const Icon(Icons.two_k),
          title: 'Second Pass',
          helpRoute: PageRouter.secondPassHelp,
          screen: const SecondPassScreen()),
      CollectionStep(
          icon: const Icon(Icons.three_k),
          title: 'Third Pass',
          helpRoute: PageRouter.thirdPassHelp,
          screen: const ThirdPassScreen()),
      CollectionStep(
          icon: const Icon(Icons.four_k),
          title: 'Fourth Pass',
          screen: const FourthPassScreen()),
      CollectionStep(
          icon: const Icon(Icons.flag),
          title: 'Finish',
          screen: const FinishCollectionPage())
    ];

    return BlocProvider(
      create: (context) =>
          CollectionBloc(collection: collection ?? GibsonsForm()),
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          final step = screens[state.activeStep];
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(state.gibsonsForm);
              return true;
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Collection: ${step.title}'),
                  actions: step.helpRoute != null
                      ? [
                          IconButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, step.helpRoute!),
                              icon: const Icon(Icons.help))
                        ]
                      : null,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    IconStepper(
                      activeStep: state.activeStep,
                      activeStepColor: Colors.teal,
                      activeStepBorderColor: Colors.teal,
                      lineColor: Colors.teal,
                      icons: screens.map((screen) => screen.icon).toList(),
                      onStepReached: (int index) => context
                          .read<CollectionBloc>()
                          .add(ActiveStepChanged(changedActiveStep: index)),
                      stepReachedAnimationDuration:
                          const Duration(milliseconds: 500),
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: step.screen),
                  ]),
                )),
          );
        },
      ),
    );
  }
}
