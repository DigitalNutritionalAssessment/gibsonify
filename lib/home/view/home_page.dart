import 'package:flutter/material.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/households/households.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify/home/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = [
    const SurveysScreen(),
    const HouseholdsScreen(),
    const RecipesScreen(viewedFromCollection: false),
    const SyncScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
        onTap: _onScreenSelected,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Surveys',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cottage),
            label: 'Households',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Import/Export',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }

  void _onScreenSelected(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
}
