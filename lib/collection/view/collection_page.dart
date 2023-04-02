import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key, this.gibsonsForm}) : super(key: key);

  final GibsonsForm? gibsonsForm;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const SensitizationScreen(),
      const FirstPassScreen(),
      const SecondPassScreen(),
      const ThirdPassScreen(),
      const FourthPassScreen(),
    ];

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        return BlocBuilder<HouseholdBloc, HouseholdState>(
          builder: (context, householdState) {
            context.read<CollectionBloc>().add(GibsonsFormProvided(
                gibsonsForm: gibsonsForm ??
                    GibsonsForm(
                        employeeNumber: loginState.loginInfo.employeeId)));
            return BlocBuilder<CollectionBloc, CollectionState>(
              builder: (context, collectionState) {
                return WillPopScope(
                  onWillPop: () async {
                    context.read<HouseholdBloc>().add(SaveCollectionRequested(
                        gibsonsForm: collectionState.gibsonsForm));
                    Navigator.of(context).pop(true);
                    return true;
                  },
                  child: Scaffold(
                    body: screens[collectionState.selectedScreenIndex()],
                    bottomNavigationBar: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: collectionState.selectedScreenIndex(),
                      onTap: (int index) {
                        const validlyCompleteSensitizationSnackBar = SnackBar(
                            content:
                                Text('Please complete all sensitization fields '
                                    'with valid values before moving on'));
                        if (collectionState.gibsonsForm
                            .isSensitizationValid()) {
                          context.read<CollectionBloc>().add(
                              SelectedScreenChanged(
                                  changedSelectedScreen: collectionState
                                      .screenOfSelectedIndex(index)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              validlyCompleteSensitizationSnackBar);
                        }
                      },
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.info),
                          label: 'Info',
                        ),
                        BottomNavigationBarItem(
                          // TODO: Change icons to just numbers
                          icon: Icon(Icons.one_k),
                          label: 'First',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.two_k),
                          label: 'Second',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.three_k),
                          label: 'Third',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.four_k),
                          label: 'Fourth',
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
