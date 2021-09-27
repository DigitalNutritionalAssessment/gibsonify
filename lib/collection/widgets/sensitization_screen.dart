import 'package:flutter/material.dart';

class SensitizationScreen extends StatefulWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  _SensitizationScreenState createState() => _SensitizationScreenState();
}

class _SensitizationScreenState extends State<SensitizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sensitization')),
        body: const Center(child: Text('Sensitization Form Fields')));
  }
}
