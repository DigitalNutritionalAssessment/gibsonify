import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui/widgets/about_tile.dart';
import 'package:flutter_uikit/utils/uidata.dart';

//import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter_uikit/model/consumption_data.dart';



Widget appBar({@required title, @required bottomBarTitle, tabs}){

  // ignore: non_constant_identifier_names
  Widget bottom_bar;

  if (bottomBarTitle != "" && tabs != null){
    print("Cannot set both bottomBar and tabs!");
  }
  else if (bottomBarTitle != ""){
    bottom_bar = bottomBar(title: bottomBarTitle);
  }
  else if (tabs != null){
    bottom_bar = TabBar(tabs:tabs);
  }

  return AppBar(
    backgroundColor: Colors.black,
    elevation: 2.0,
    title: Text(title),
    bottom: bottom_bar,
  );
}

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
            )
          ],
        ),
      ),
    ),
  ),
);


class CollectionCommonDrawer extends StatelessWidget {

  final VoidCallback goToPageStateSensitisation;
  final VoidCallback goToPageStateInfo;
  final VoidCallback goToPageStateFirstPage;
  final VoidCallback goToPageStateSecondPage;
  final VoidCallback goToPageStateThirdPage;
  final VoidCallback goToPageStateFourthPage;

  const CollectionCommonDrawer({
    this.goToPageStateSensitisation,
    this.goToPageStateInfo,
    this.goToPageStateFirstPage,
    this.goToPageStateSecondPage,
    this.goToPageStateThirdPage,
    this.goToPageStateFourthPage,
});




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Person.getEnumeratorFromSharedPrefs(),
      builder: (BuildContext ctx, AsyncSnapshot<Person> snapshot){
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  snapshot.data?.name ??"Choon Kiat Lee",
                ),
                accountEmail: Text(
                  "Employee Number: " +
                  snapshot.data?.employeeNumber.toString() ?? "choonkiat.lee@gmail.com",
                ),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new AssetImage(UIData.pkImage),
                ),
              ),
              new ListTile(
                title: Text(
                  "Sensitisation",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                onTap: () => {goToPageStateSensitisation(), Navigator.pop(context)},
              ),
              Divider(),
              new ListTile(
                title: Text(
                  "Interviewee Info",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                onTap: () => {goToPageStateInfo(), Navigator.pop(context)},
              ),
              new ListTile(
                title: Text(
                  "First Pass",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.filter_1,
                  color: Colors.green,
                ),
                onTap: () => {goToPageStateFirstPage(), Navigator.pop(context)},
              ),
              new ListTile(
                title: Text(
                  "Second Pass",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.filter_2,
                  color: Colors.red,
                ),
                onTap: () => {goToPageStateSecondPage(), Navigator.pop(context)},
              ),
              new ListTile(
                title: Text(
                  "Third Pass",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.filter_3,
                  color: Colors.cyan,
                ),
                onTap: () => {goToPageStateThirdPage(), Navigator.pop(context)},
              ),
              Divider(),
              new ListTile(
                title: Text(
                  "Fourth Pass",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.filter_4,
                  color: Colors.brown,
                ),
                onTap: () => {goToPageStateFourthPage(), Navigator.pop(context)},
              ),
              Divider(),
              (snapshot.data?.name == null)?
              new ListTile(
                title: Text(
                  "Log In",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.filter_4,
                  color: Colors.brown,
                ),
                onTap: () => {goToPageStateFourthPage(), Navigator.pop(context)},
              )
              :Container(),
//              Divider(),
              MyAboutTile()
            ],
          ),
        );
      },
    );
  }
}
