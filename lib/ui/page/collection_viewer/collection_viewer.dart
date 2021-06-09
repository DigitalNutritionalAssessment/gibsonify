import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/model/consumption_data_db.dart';

import 'package:flutter_uikit/ui/page/collection/collection_state_machine.dart';

//this page is the view data page from the home page

class CollectionViewer extends StatefulWidget {
  @override
  _CollectionViewerState createState() => _CollectionViewerState();
}

class _CollectionViewerState extends State<CollectionViewer> {
  List<ConsumptionData> consumptionDataList = [];

  final LocalItemStorage localItemStorage = LocalItemStorage();

  Future<List<ConsumptionData>> getConsumptionDataFromDB() async {
    List<String> filenames = await localItemStorage.listAllFiles();
    return await Stream.fromIterable(filenames)
        .asyncMap((filename) {
          String id = ConsumptionData.getIdFromFileName(filename);
          return (id != null) ? ConsumptionData().load(filename) : null;
        })
        .skipWhile((elem) => elem == null)
        .toList();
  }

  Future updateConsumptionDataList() async {
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
            Map<String, dynamic> openFinalReportArgs = {
              "consumptionData": consumptionDataList[idx],
              "initialPageState": PageState.FOURTH_PASS,
            };
            Map<String, dynamic> openInterviewArgs = {
              "consumptionData": consumptionDataList[idx],
              "initialPageState": PageState.INTERVIEW,
            };

            BoxDecoration listTileDecoration;
            String statusString;

            if (consumptionDataList[idx].interviewData.interviewStart != null) {
              if (consumptionDataList[idx].interviewData.interviewOutcome ==
                  InterviewOutcomeSelection.COMPLETED) {
                listTileDecoration = BoxDecoration(color: Colors.greenAccent);
                statusString = "Completed!";
              } else {
                listTileDecoration = BoxDecoration(color: Colors.yellowAccent);
                statusString = "Inverview Incomplete";
              }
            } else {
              listTileDecoration = BoxDecoration(color: Colors.orangeAccent);
              statusString = "Sensitisation Visit Complete";
            }

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
                child: Container(
                  decoration: listTileDecoration,
                  child: ListTile(
                    title: Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Name: " +
                                    consumptionDataList[idx]
                                        ?.interviewData
                                        ?.respondent
                                        ?.name ??
                                "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              (consumptionDataList[idx]
                                          ?.interviewData
                                          ?.sensitizationVisitDate
                                          ?.day
                                          ?.toString() ??
                                      "") +
                                  "/" +
                                  (consumptionDataList[idx]
                                          ?.interviewData
                                          ?.sensitizationVisitDate
                                          ?.month
                                          ?.toString() ??
                                      ""),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Status: " + (statusString ?? ""),
                          style: UIData.smallTextStyle,
//                        TextStyle(
//                            color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ]),
                    onTap: () {
//                    Navigator.pop(context);

                      // If there is no
                      if (consumptionDataList[idx]
                              .interviewData
                              .interviewStart !=
                          null) {
                        Navigator.pushNamed(
                            context, UIData.newCollectionSessionRoute,
                            arguments: openFinalReportArgs);
                      } else {
                        Navigator.pushNamed(
                            context, UIData.newCollectionSessionRoute,
                            arguments: openInterviewArgs);
                      }
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: new Text("JSON viewer"),
                              content: SingleChildScrollView(
                                  child: new Text(
                                      jsonEncode(consumptionDataList[idx]))),
                              actions: <Widget>[
                                new TextButton(
                                  //change from flatbutton to TextButton
                                  child: new Text("Done"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
