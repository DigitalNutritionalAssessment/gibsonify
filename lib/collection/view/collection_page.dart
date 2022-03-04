import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/home/home.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const SensitizationScreen(),
      const FirstPassScreen(),
      const SecondPassScreen(),
      const ThirdPassScreen(),
      const FourthPassScreen(),
    ];

    /// Custom pop function used in `WillPopScope`'s `onWillPop` argument in
    /// `CollectionPage` to override the Android Back button and swipe gesture
    /// to save current Collection and reload all Collections to `HomeBloc`.
    Future<bool> _popCollectionPage(BuildContext context) async {
      context.read<CollectionBloc>().add(const GibsonsFormSaved());
      context.read<HomeBloc>().add(const GibsonsFormsLoaded());
      Navigator.of(context).pop(true);
      return true;
    }

    return WillPopScope(
      onWillPop: () => _popCollectionPage(context),
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return Scaffold(
            body: _screens[state.selectedScreenIndex()],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.selectedScreenIndex(),
              onTap: (int index) => context.read<CollectionBloc>().add(
                  SelectedScreenChanged(
                      changedSelectedScreen:
                          state.screenOfSelectedIndex(index))),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.description),
                  label: 'Sensitization',
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
          );
        },
      ),
    );
  }
}
