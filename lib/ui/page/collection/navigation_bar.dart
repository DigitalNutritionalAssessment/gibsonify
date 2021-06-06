//This shows what can be implemented into the other states

import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: NavBar(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class NavBar extends StatefulWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}
//This is where all the is navigation is stored
//The text display is not needed but is shown as a demo
class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Sensitisation',
      style: optionStyle,
    ),
    Text(
      'Interview Info',
      style: optionStyle,
    ),
    Text(
      'First Pass',
      style: optionStyle,
    ),
        Text(
      'Second Pass',
      style: optionStyle,
    ),
        Text(
      'Probe List',
      style: optionStyle,
    ),
        Text(
      'Third Pass',
      style: optionStyle,
    ),
        Text(
      'Fourth Pass',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
//There is an issue that background colours cannot have shades
//many icons to choose from! I chose these to reflect the context of the state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ICRISAT Navigation Bar'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.living),
            label: 'Sensitisation',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speaker_notes_outlined),
            label: 'Interview',
            backgroundColor: Colors.pinkAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: 'First Pass',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Second Pass',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: 'Probe List',
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lunch_dining_outlined),
            label: 'Third Pass',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Fourth Pass',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[200],
        onTap: _onItemTapped,
      ),
    );
  }
}
