import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui/widgets/common_scaffold.dart';
import 'package:flutter_uikit/ui/widgets/common_switch.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/ui/widgets/common_dialogs.dart';

import 'package:flutter_uikit/model/consumption_data_db.dart';


class SettingsOnePage extends StatelessWidget {
  Widget bodyData({BuildContext parentContext}) => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "General Settings",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      title: Text("Account"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.pop(parentContext);
                        Navigator.pushNamed(
                          parentContext, UIData.loginRoute,);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.sync,
                        color: Colors.red,
                      ),
                      title: Text("Sync Database"),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.get_app,
                        color: Colors.blue,
                      ),
                      title: Text("Sync Data"),
                      trailing: Icon(Icons.arrow_right),
                    )
                  ],
                ),
              ),

              //2
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Examine Data",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.view_agenda,
                        color: Colors.grey,
                      ),
                      title: Text("View Data"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: (){
                        Navigator.pop(parentContext);
                        Navigator.pushNamed(
                          parentContext, UIData.ViewDataRoute,);
                      },
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.playlist_add,
                          color: Colors.amber,
                        ),
                        title: Text("Add More Data"),
                        trailing: CommonSwitch(
                          defValue: true,
                        ),
                      onTap: (){
                        Navigator.pop(parentContext);
                        Navigator.pushNamed(
                          parentContext, UIData.newCollectionSessionRoute,);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: Colors.blue,
                      ),
                      title: Text("Delete all Data Files! Careful..."),
                      trailing: CommonSwitch(
                        defValue: false,
                      ),
                      onTap: (){
                        _showDeleteDialog(parentContext: parentContext);
                      },
                    ),
                  ],
                ),
              ),

//              //3
//              Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: Text(
//                  "Sound",
//                  style: TextStyle(color: Colors.grey.shade700),
//                ),
//              ),
//              Card(
//                color: Colors.white,
//                elevation: 2.0,
//                child: Column(
//                  children: <Widget>[
//                    ListTile(
//                      leading: Icon(
//                        Icons.do_not_disturb_off,
//                        color: Colors.orange,
//                      ),
//                      title: Text("Silent Mode"),
//                      trailing: CommonSwitch(
//                        defValue: false,
//                      ),
//                    ),
//                    ListTile(
//                      leading: Icon(
//                        Icons.vibration,
//                        color: Colors.purple,
//                      ),
//                      title: Text("Vibrate Mode"),
//                      trailing: CommonSwitch(
//                        defValue: true,
//                      ),
//                    ),
//                    ListTile(
//                      leading: Icon(
//                        Icons.volume_up,
//                        color: Colors.green,
//                      ),
//                      title: Text("Sound Volume"),
//                      trailing: Icon(Icons.arrow_right),
//                    ),
//                    ListTile(
//                      leading: Icon(
//                        Icons.phonelink_ring,
//                        color: Colors.grey,
//                      ),
//                      title: Text("Ringtone"),
//                      trailing: Icon(Icons.arrow_right),
//                    )
//                  ],
//                ),
//              ),
            ],
          ),
        ),
      );


  void _showDeleteDialog({BuildContext parentContext}){
    showDialog(
      context: parentContext,
      builder: (BuildContext ctx){
        return AlertDialog(
          title: new Text("Delete all items"),
          content: new Text("This will delete all collection data text files on your device permanently. Have you backed it up first?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(parentContext).pop();
              },
            ),
            new FlatButton(
              child: new Text("Delete All"),
              onPressed: () {
                LocalItemStorage().deleteAllConsumptionDataFiles();
                Navigator.of(parentContext).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Settings",
      showDrawer: false,
      showFAB: false,
      backGroundColor: Colors.grey.shade300,
      bodyData: bodyData( parentContext: context ),
    );
  }
}
