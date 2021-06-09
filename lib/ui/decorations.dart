import 'package:flutter/material.dart';

//this is a new file created for a bullet point
//can also create other things and can be easily referred back
//this is used a lot in the help prompts in each page

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