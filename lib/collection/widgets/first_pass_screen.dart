import 'package:flutter/material.dart';

class FirstPassScreen extends StatefulWidget {
  const FirstPassScreen({Key? key}) : super(key: key);

  @override
  _FirstPassScreenState createState() => _FirstPassScreenState();
}

class _FirstPassScreenState extends State<FirstPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('First Pass')),
        body: const Center(child: Text('First Pass Form Fields')));
  }
}
