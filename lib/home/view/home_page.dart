import 'package:flutter/material.dart';

import 'package:gibsonify/home/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedScreenIndex = 0;

  // TODO: add all main screens
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
