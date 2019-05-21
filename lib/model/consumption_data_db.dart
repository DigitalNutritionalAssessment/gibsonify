import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter_uikit/model/consumption_data.dart';


////////////////////////////// Database Code here /////////////////////////////
// Open the database and store the reference

class LocalItemStorage{

  final fileName;

  const LocalItemStorage({
    this.fileName,
  });

  Future<String> get _localPath async {

    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
//    print(isAbsolute(fileName));
//    if (isAbsolute(fileName)){
//      return File(fileName);
//    }else return File(join(path,path??'default.txt'));

    return (isAbsolute(fileName))?File(fileName):File(join(path,fileName??'default.txt'));
  }

  Future<ConsumptionData> readConsumptionData() async {
    try {
      final file = await localFile;
      // Read the file
      String contents = await file.readAsString();
      Map consumptionDataMap = jsonDecode(contents);
      print(consumptionDataMap);
      return new ConsumptionData.fromJson(consumptionDataMap);
    } catch (e) {
      // If encountering an error, return 0
      print(e);
      return null;
    }
  }

  Future<File> writeConsumptionData(ConsumptionData consumptionData) async {
    final file = await localFile;
    // Write the file
    return file.writeAsString(jsonEncode(consumptionData));
  }

  Future deleteAllConsumptionDataFiles() async {
    final dir = await _localPath;

    for (var file in Directory(dir).listSync()) {
      if (file is File && file.path.contains(".txt")){
        await file.delete();
      }
    }
  }

  Future<List<String>> listAllFiles() async{
    final dir = await _localPath;

    List<String> listOfFilePaths = [];

    for (var file in Directory(dir).listSync()) {
      if (file is File){
        listOfFilePaths.add(file.absolute.path);
      }
    }
    return listOfFilePaths;
  }

}