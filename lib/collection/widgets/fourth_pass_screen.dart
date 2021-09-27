import 'package:flutter/material.dart';

class FourthPassScreen extends StatefulWidget {
  const FourthPassScreen({Key? key}) : super(key: key);

  @override
  _FourthPassScreenState createState() => _FourthPassScreenState();
}

class _FourthPassScreenState extends State<FourthPassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Fourth Pass')),
        body: const Center(child: Text('Fourth Pass Form Fields')));
  }
}
