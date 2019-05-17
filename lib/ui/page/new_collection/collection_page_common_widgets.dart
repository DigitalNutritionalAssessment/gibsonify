import 'package:flutter/material.dart';


Widget appBar({@required title, @required bottomBarTitle}) => AppBar(
  backgroundColor: Colors.black,
  elevation: 2.0,
  title: Text(title),
  bottom: bottomBar(title: bottomBarTitle),
);

Widget bottomBar({@required title}) => PreferredSize(
  preferredSize: Size(double.infinity, 50.0),
  child: Container(
    color: Colors.black,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    ),
  ),
);