import 'package:flutter/material.dart';

import 'package:gibsonify/screens/collections_screen.dart';
import 'package:gibsonify/screens/recipes_screen.dart';
import 'package:gibsonify/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex = 0;

  // TODO:
  final List<Widget> _screens = [
    const CollectionsScreen(),
    const RecipesScreen(),
    // SyncScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _onScreenSelected,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // TODO: Find out why upon adding a fourth item it suddenly stops
          // displaying the BottomNavigationBar
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.sync),
          //   label: 'Yo',
          // ),
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
