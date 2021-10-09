import 'package:flutter/material.dart';

import 'package:gibsonify/collection/collection.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = [
    const SensitizationScreen(),
    const FirstPassScreen(),
    const SecondPassScreen(),
    const ThirdPassScreen(),
    const FourthPassScreen(),
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
  }

  void _onScreenSelected(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
}
