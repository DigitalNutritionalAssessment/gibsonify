import 'package:flutter/material.dart';

class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
    height: 10.0,
    width: 10.0,
    decoration: new BoxDecoration(
    color: Colors.blue[900],
    shape: BoxShape.circle,
  ),
  );
  }
}