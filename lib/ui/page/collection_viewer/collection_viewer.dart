import 'dart:io';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/model/consumption_data_db.dart';

import 'package:flutter_uikit/ui/page/collection/collection_state_machine.dart';



class CollectionViewer extends StatefulWidget {
  @override
  _CollectionViewerState createState() => _CollectionViewerState();
}

class _CollectionViewerState extends State<CollectionViewer> {

  List<ConsumptionData> consumptionDataList = [];

  final LocalItemStorage localItemStorage = LocalItemStorage();

  Future<List<ConsumptionData>> getConsumptionDataFromDB() async{
    List<String> filenames = await localItemStorage.listAllFiles();
    return await Stream.fromIterable(filenames)
        .asyncMap((filename) {
      String id = ConsumptionData.getIdFromFileName(filename);
      return (id!=null)? ConsumptionData().load(filename):null;
    }).skipWhile((elem) => elem == null).toList();
  }

  Future updateConsumptionDataList() async{
    var tmpList = await getConsumptionDataFromDB();
    setState(() {
      consumptionDataList = tmpList;
    });
  }

  @override
  void initState() {
    updateConsumptionDataList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 2.0,
        title: Text("Data Viewer"),
    ),
    body: ListView.builder(
      itemCount: (consumptionDataList?.length ?? 0),
      itemBuilder: (BuildContext ctx, int idx) {
          Map<String, dynamic> args = {
            "consumptionData": consumptionDataList[idx],
            "initialPageState": PageState.FOURTH_PASS,
          };

          return Dismissible(
            key: ObjectKey(consumptionDataList[idx] ?? null),
            onDismissed: (direction) {
              File(consumptionDataList[idx].filename).deleteSync();
              setState(() {
                consumptionDataList.removeAt(idx);
              });
              updateConsumptionDataList();
            },
            child: Card(
              elevation: 2.0,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Name: " +
                          consumptionDataList[idx]?.interviewData
                              ?.respondent
                              ?.name ?? "",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        consumptionDataList[idx]?.interviewData
                            ?.interviewStart
                            ?.day?.toString()
                            + "/"
                            + consumptionDataList[idx]?.interviewData
                            ?.interviewStart?.month?.toString(),

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, UIData.newCollectionSessionRoute,
                      arguments: args);
                },
                onLongPress: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx){
                        return AlertDialog(
                            title: new Text("JSON viewer"),
                            content: SingleChildScrollView(child: new Text(jsonEncode(consumptionDataList[idx]))),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("Done"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ],
                        );
                      }
                  );
                },
              ),
            ),
          );
      }
    ),
    );
  }
}