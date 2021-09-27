import 'package:flutter/material.dart';

class ThirdPassScreen extends StatefulWidget {
  const ThirdPassScreen({Key? key}) : super(key: key);

  @override
  _ThirdPassScreenState createState() => _ThirdPassScreenState();
}

class _ThirdPassScreenState extends State<ThirdPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Third Pass')),
        body: const Center(child: Text('Third Pass Form Fields')));
  }
}
