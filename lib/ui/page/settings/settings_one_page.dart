import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter_uikit/ui/widgets/common_scaffold.dart';
import 'package:flutter_uikit/ui/widgets/common_switch.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/ui/widgets/common_dialogs.dart';

import 'package:flutter_uikit/model/consumption_data_db.dart';
import 'package:flutter_uikit/model/consumption_data.dart';


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
                      onTap: () => syncData(parentContext),
                    ),
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

  Future<http.Response> sendConsumptionDataJson(String json) async {
    final response = await http.post(
      UIData.send_consumption_data_api_url,
      headers: {"Content-Type": "application/json"},
      body: json,
    );
    print(response);
    return response;
  }

  Future sendAllConsumptionData(BuildContext ctx) async{
    LocalItemStorage localItemStorage = LocalItemStorage();
    // Read all data from the db
    List<String> filenames = await localItemStorage.listAllFiles();

    bool success = true;
    for (var filename in filenames){
      if (!filename.contains(".txt")) continue;
      String contents = await File(filename).readAsString();
      print(contents);
      try{
        final response = await http.post(
          UIData.send_consumption_data_api_url,
          body: contents,
        );
        if (response.statusCode != 200){
          success=false;
          showSuccess(ctx,
              "An error occured while sending the data!\n"
                + ((UIData.isInDebugMode)?"Error message: Response status code: (" + response.statusCode.toString() + ")":""),
              Icons.cancel,
              iconColor: Colors.red);
        }
      }catch (e){
        success=false;
        showSuccess(ctx,
            "An error occured while sending the data!\n" + ((UIData.isInDebugMode)?"Error message: (" + e.toString() + ")" : ""),
            Icons.cancel,
            iconColor: Colors.red);
      }
    }

    if (success) showSuccess(ctx,"Successfully Synced Data", Icons.sync);
  }
  
  void syncData(BuildContext ctx){
    sendAllConsumptionData(ctx);
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
