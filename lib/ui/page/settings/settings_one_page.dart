import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_uikit/ui/widgets/common_scaffold.dart';
import 'package:flutter_uikit/ui/widgets/about_tile.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:flutter_uikit/utils/form_strings.dart';
import 'package:flutter_uikit/ui/widgets/common_dialogs.dart';
import 'package:flutter_uikit/model/consumption_data_db.dart';
import 'package:flutter_uikit/ui/widgets/collection_question.dart';


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
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.person,
                    //     color: Colors.grey,
                    //   ),
                    //   title: Text("About"),
                    //   trailing: Icon(Icons.arrow_right),
                    //   onTap: (){
                    //     // Navigator.pop(parentContext);
                    //     // Navigator.pushNamed(
                    //     //   parentContext, UIData.loginRoute,);
                        
                    //   },
                    // ),
                    MyAboutTile(),
                    
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
                        trailing: Icon(Icons.arrow_right),
                        // CommonSwitch(
                        //   defValue: true,
                        // ),
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
                      trailing: Icon(Icons.arrow_right),
                      // CommonSwitch(
                      //   defValue: false,
                      // ),
                      onTap: (){
                        _showDeleteDialog(parentContext: parentContext);
                      },
                    ),
                  ],
                ),
              ),

             //3
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Text(
                 "Sync",
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
                        Icons.sync,
                        color: Colors.red,
                      ),
                      title: Text("Switch Recipe Database"),
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

              //4
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Developer Options",
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
                        Icons.edit,
                        color: Colors.red,
                      ),
                      title: Text("Modify data sync base url"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () => _showModifyBaseURLDialog(parentContext),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      );

  void _showModifyBaseURLDialog(BuildContext parentContext){

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
        context: parentContext,
        builder: (BuildContext ctx){
          return AlertDialog(
            title: new Text("Input new base url"),
            content: Form(
              key: _formKey,
              child: FormQuestion(
                questionText: "Input new base url",
                hint: "",
                initialText: UIData.api_base_url??"",
                onSaved: (answer) => UIData.api_base_url = answer,
                validate: emptyFieldValidator,
              ),
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(parentContext).pop();
                },
              ),
              new TextButton(
                child: new Text("Update Base URL"),
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    Navigator.of(parentContext).pop();
                  }
                },
              ),
            ],
          );
        }
    );
  }

  void _showDeleteDialog({BuildContext parentContext}){
    //show pop up dialog to warn the user when pressed
    showDialog(
      context: parentContext,
      builder: (BuildContext ctx){
        return AlertDialog(
          title: new Text("Delete all items"),
          content: new Text("This will delete all collection data text files on your device permanently. Have you backed it up first?"),
          actions: <Widget>[
            new TextButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(parentContext).pop();
              },
            ),
            new TextButton(
              child: new Text("Delete All"),
              onPressed: () {
                LocalItemStorage().deleteAllConsumptionDataFiles();
                Navigator.of(parentContext).pop();
                //navigator.pop() essentially closes the "tab"
              },
            ),
          ],
        );
      }
    );
  }

  Future<http.Response> sendConsumptionDataJson(String json) async {
    final response = await http.post(
      UIData.api_base_url + UIData.send_consumption_data_api_path,
      headers: {"Content-Type": "application/json"},
      body: json,
    );
    print(response);
    return response;
  }

  Future sendAllConsumptionData(BuildContext ctx) async{
    //this is to send all the data to the database when wifi is connected and after the sync button has been pressed
    LocalItemStorage localItemStorage = LocalItemStorage();
    // Read all data from the db
    List<String> filenames = await localItemStorage.listAllFiles();

    bool success = true;
    for (var filename in filenames){
      if (!filename.contains(".json")) continue;
      String contents = await File(filename).readAsString();
      print(contents);
      try{
        final response = await http.post(
          UIData.api_base_url + UIData.send_consumption_data_api_path,
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
