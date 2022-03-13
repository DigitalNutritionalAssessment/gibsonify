import 'package:flutter/material.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, PageRouter.settingsHelp),
                icon: const Icon(Icons.help))
          ],
        ),
        body: const Center(child: Text('No settings currently available')));
  }
}
