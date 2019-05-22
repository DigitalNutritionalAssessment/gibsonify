import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_uikit/model/consumption_data.dart';

import 'package:flutter_uikit/ui/widgets/common_dialogs.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Person user = Person();

  SharedPreferences _prefs;

  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _employeeNumberTextController = TextEditingController();

  @override
  void initState() {
    getEnumeratorInfo();
    super.initState();
  }

  void getEnumeratorInfo() async{
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      user.name = _prefs.getString("userName");
      user.employeeNumber = _prefs.getInt("employeeNumber");
    });

    _userNameTextController.text = user.name ?? "";
    _employeeNumberTextController.text = user.employeeNumber?.toString()??"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[loginHeader(), loginFields(context)],
          ),
        ),
      ),
    );
  }


  loginHeader() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
//          FlutterLogo(
//            colors: Colors.green,
//            size: 80.0,
//          ),
      Image.asset(
        UIData.iconImage,
        height: 80.0,
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "Welcome to ${UIData.appName}",
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
      ),
      SizedBox(
        height: 5.0,
      ),
      Text(
        (user.name != "" && user.name != null) ? (user.name??"") :  "Not logged in yet...",
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );

  loginFields(BuildContext context) => Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enter your name",
              labelText: "Name",
            ),
            controller: _userNameTextController,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Employee Number",
              labelText: "Employee Number",
            ),
            keyboardType: TextInputType.number,
            controller: _employeeNumberTextController,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          width: double.infinity,
          child: RaisedButton(
            padding: EdgeInsets.all(12.0),
            shape: StadiumBorder(),
            child: Text(
              "UPDATE USER INFO" ,
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
            onPressed: () {
              _prefs.setInt("employeeNumber", int.tryParse(_employeeNumberTextController.text)??"" );
              _prefs.setString("userName", _userNameTextController.text??"");

              setState(() {
                getEnumeratorInfo();
              });

              showSuccess(context, "User Data Saved!", Icons.save_alt);

            },
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        FlatButton(
          child: Text(
            "LOG OUT",
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: () => showLogoutDialog(context),
        ),
      ],
    ),
  );


  void showLogoutDialog(BuildContext parentContext){
    showDialog(
        context: parentContext,
        builder: (BuildContext ctx){
        return AlertDialog(
          title: Text("LOG OUT"),
          content: Text("Are you sure you want to log out? This cannot be undone!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(parentContext).pop();
              },
            ),
            new FlatButton(
              child: new Text("Log Out"),
              onPressed: () {
                _prefs.setInt("employeeNumber",null);
                _prefs.setString("userName","");

                setState(() {
                  getEnumeratorInfo();
                });

                Navigator.of(parentContext).pop();
              },
            )
          ],
        );
      }
    );
  }

}