import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'import_export_event.dart';
part 'import_export_state.dart';

class ImportExportBloc extends Bloc<ImportExportEvent, ImportExportState> {
  final GibsonifyRepository _gibsonifyRepository;

  ImportExportBloc({required GibsonifyRepository gibsonifyRepository})
      : _gibsonifyRepository = gibsonifyRepository,
        super(const ImportExportState()) {
    on<DataSavedToFiles>(_onDataSavedToFiles);
    on<DataShared>(_onDataShared);
  }

  void _onDataSavedToFiles(
      DataSavedToFiles event, Emitter<ImportExportState> emit) async {
    List<GibsonsForm?> gibsonsForms = _gibsonifyRepository.loadForms();
    List<Recipe> recipes = _gibsonifyRepository.loadRecipes();

    int finishedGibsonsFormsNumber = gibsonsForms
        .where((gibsonsForm) => gibsonsForm != null && gibsonsForm.finished)
        .length;
    int recipesNumber = recipes.length;

    if (finishedGibsonsFormsNumber == 0 && recipesNumber == 0) {
      emit(state.copyWith(
          dataSaveStatus: DataSaveStatus.noData,
          exportedGibsonsFormsNumber: 0,
          exportedRecipesNumber: 0));
      emit(state.copyWith(dataSaveStatus: DataSaveStatus.notRequested));
      return;
    }

    String finishedGibsonsFormsCsv =
        _convertFinishedGibsonsFormsToCsv(gibsonsForms);
    String recipesCsv = _convertRecipesToCsv(recipes);

    try {
      if (!await Permission.storage.request().isGranted) {
        emit(state.copyWith(
            dataSaveStatus: DataSaveStatus.noPermissionToSaveFiles,
            exportedGibsonsFormsNumber: 0,
            exportedRecipesNumber: 0));
      } else {
        String currentDateTime =
            DateFormat("yyyy-MM-dd-HH-mm-ss").format(DateTime.now());
        String downloadsPath = '/storage/emulated/0/Download';

        var collectionFilePath =
            downloadsPath + '/collection-data-$currentDateTime.csv';

        var recipeFilePath =
            downloadsPath + '/recipe-data-$currentDateTime.csv';

        var collectionFile = File(collectionFilePath);
        collectionFile.writeAsString(finishedGibsonsFormsCsv);

        var recipeFile = File(recipeFilePath);
        recipeFile.writeAsString(recipesCsv);

        emit(state.copyWith(
            dataSaveStatus: DataSaveStatus.success,
            exportedGibsonsFormsNumber: finishedGibsonsFormsNumber,
            exportedRecipesNumber: recipesNumber));
      }
    } catch (e) {
      emit(state.copyWith(
          dataSaveStatus: DataSaveStatus.error,
          // TODO: there might be partial data saved, handle such cases
          exportedGibsonsFormsNumber: 0,
          exportedRecipesNumber: 0));
    }

    emit(state.copyWith(dataSaveStatus: DataSaveStatus.notRequested));
  }

  void _onDataShared(DataShared event, Emitter<ImportExportState> emit) async {
    List<GibsonsForm?> gibsonsForms = _gibsonifyRepository.loadForms();
    List<Recipe> recipes = _gibsonifyRepository.loadRecipes();

    int finishedGibsonsFormsNumber = gibsonsForms
        .where((gibsonsForm) => gibsonsForm != null && gibsonsForm.finished)
        .length;
    int recipesNumber = recipes.length;

    if (finishedGibsonsFormsNumber == 0 && recipesNumber == 0) {
      emit(state.copyWith(
          dataShareStatus: DataShareStatus.noData,
          exportedGibsonsFormsNumber: 0,
          exportedRecipesNumber: 0));
      emit(state.copyWith(dataSaveStatus: DataSaveStatus.notRequested));
      return;
    }

    String finishedGibsonsFormsCsv =
        _convertFinishedGibsonsFormsToCsv(gibsonsForms);
    String recipesCsv = _convertRecipesToCsv(recipes);

    try {
      final applicationDocumentsDirectory =
          await getApplicationDocumentsDirectory();

      String currentDateTime =
          DateFormat("yyyy-MM-dd-HH-mm-ss").format(DateTime.now());

      var collectionFilePath = applicationDocumentsDirectory.path +
          '/collection-data-$currentDateTime.csv';

      var recipeFilePath = applicationDocumentsDirectory.path +
          '/recipe-data-$currentDateTime.csv';

      var collectionFile = File(collectionFilePath);
      collectionFile.writeAsString(finishedGibsonsFormsCsv);

      var recipeFile = File(recipeFilePath);
      recipeFile.writeAsString(recipesCsv);
      await Share.shareFiles([collectionFilePath, recipeFilePath])
          // TODO: fix the then() block being executed before share dialog closes
          // maybe with a whenComplete() ???
          .then((value) {
        collectionFile.delete();
        recipeFile.delete();
        emit(state.copyWith(
            dataShareStatus: DataShareStatus.success,
            exportedGibsonsFormsNumber: finishedGibsonsFormsNumber,
            exportedRecipesNumber: recipesNumber));
      });
    } catch (e) {
      emit(state.copyWith(
          dataShareStatus: DataShareStatus.error,
          exportedGibsonsFormsNumber: 0,
          exportedRecipesNumber: 0));
    }

    emit(state.copyWith(dataShareStatus: DataShareStatus.notRequested));
  }
}

// TODO: move this function to the API
String _convertFinishedGibsonsFormsToCsv(List<GibsonsForm?> gibsonsForms) {
  String finishedGibsonsFormsCsvHeader =
      'Collection ID,Employee Number,Household ID,Respondent Name,'
      'Respondent Country Code,Respondent Tel Number Prefix,'
      'Respondent Tel Number,Sensitization Date,Recall Day,'
      'Interview Date,Interview Start Time,GPS Location,'
      'Picture Chart Collected,Picture Chart Not Collected Reason,'
      'Interview End Time,Interview Finished In One Visit,'
      'Second Interview Visit Date,Second Visit Reason,Interview Outcome,'
      'Interview Not Completed Reason,Comments,Is Finished,Food Item ID,'
      'Food Item Name,Food Item Time Period,Food Item Source,'
      'Ingredients Description,Preparation Method,Confirmed,'
      'Recipe Number,Recipe Date,Recipe Name,Measurements\n';

  String finishedGibsonsFormsCsv = finishedGibsonsFormsCsvHeader;

  for (GibsonsForm? gibsonsForm in gibsonsForms) {
    if (gibsonsForm != null && gibsonsForm.finished) {
      finishedGibsonsFormsCsv += gibsonsForm.toCsv();
    }
  }
  return finishedGibsonsFormsCsv;
}

// TODO: move this function to the API
String _convertRecipesToCsv(List<Recipe> recipes) {
  String recipesCsvHeader =
      'Employee Number,Recipe Number,Date,Recipe Name,Recipe Type,'
      'Recipe attribute,Recipe Measurement,Recipe Probe Name,'
      'Recipe Probe Answers,Ingredient Name,Ingredient Description,'
      'Cooking State,Ingredient Measurement\n';

  String recipesCsv = recipesCsvHeader;

  for (Recipe recipe in recipes) {
    recipesCsv += recipe.toCsv();
  }

  return recipesCsv;
}
