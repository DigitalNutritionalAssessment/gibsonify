import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

class MyAboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: IconButton(
          icon: Image.asset(UIData.iconImage),
          onPressed: () => {},
          padding: EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0)),
      icon: IconButton(
          icon: Image.asset(UIData.iconImage),
          onPressed: () => {},
          padding: EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0)),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed By Choon Kiat Lee, Greg Chu & Juan Rodgers\n",
        ),
        Text(
          "Based on: Flutter-UI-Kit",
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: "1.1",
      applicationLegalese: "Apache License 2.0",
    );
  }
}
