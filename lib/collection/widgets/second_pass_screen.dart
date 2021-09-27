import 'package:flutter/material.dart';

class SecondPassScreen extends StatefulWidget {
  const SecondPassScreen({Key? key}) : super(key: key);

  @override
  _SecondPassScreenState createState() => _SecondPassScreenState();
}

class _SecondPassScreenState extends State<SecondPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Second Pass')),
        body: const Center(child: Text('Second Pass Form Fields')));
  }
}
