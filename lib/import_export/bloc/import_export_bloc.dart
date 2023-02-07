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
  final IsarRepository _isarRepository;

  ImportExportBloc(
      {required GibsonifyRepository gibsonifyRepository,
      required IsarRepository isarRepository})
      : _gibsonifyRepository = gibsonifyRepository,
        _isarRepository = isarRepository,
        super(const ImportExportState()) {
    on<DataSavedToDevice>(_onDataSavedToDevice);
    on<DataShared>(_onDataShared);
  }

  void _onDataSavedToDevice(
      DataSavedToDevice event, Emitter<ImportExportState> emit) async {
    List<Household> households = await _isarRepository.readHouseholds();
    List<Recipe> recipes = _gibsonifyRepository.loadRecipes();

    int finishedGibsonsFormsNumber = households
        .expand((household) => household.respondents
            .expand((respondent) => respondent.collections))
        .where((gibsonsForm) => gibsonsForm.finished)
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

    String finishedGibsonsFormsCsv = householdsToLegacyCsvExport(households);
    String recipesCsv = convertRecipesToCsv(recipes);

    try {
      // TODO: Migrate to scoped storage (https://developer.android.com/training/data-storage/use-cases#handle-non-media-files)
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
            '$downloadsPath/collection-data-$currentDateTime.csv';

        var recipeFilePath = '$downloadsPath/recipe-data-$currentDateTime.csv';

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
    List<Household> households = await _isarRepository.readHouseholds();
    List<Recipe> recipes = _gibsonifyRepository.loadRecipes();

    int finishedGibsonsFormsNumber = households
        .expand((household) => household.respondents
            .expand((respondent) => respondent.collections))
        .where((gibsonsForm) => gibsonsForm.finished)
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

    String finishedGibsonsFormsCsv = householdsToLegacyCsvExport(households);
    String recipesCsv = convertRecipesToCsv(recipes);

    try {
      final applicationDocumentsDirectory =
          await getApplicationDocumentsDirectory();

      String currentDateTime =
          DateFormat("yyyy-MM-dd-HH-mm-ss").format(DateTime.now());

      var collectionFilePath =
          '${applicationDocumentsDirectory.path}/collection-data-$currentDateTime.csv';

      var recipeFilePath =
          '${applicationDocumentsDirectory.path}/recipe-data-$currentDateTime.csv';

      var collectionFile = File(collectionFilePath);
      collectionFile.writeAsString(finishedGibsonsFormsCsv);

      var recipeFile = File(recipeFilePath);
      recipeFile.writeAsString(recipesCsv);
      await Share.shareXFiles(
              [XFile(collectionFilePath), XFile(recipeFilePath)])
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
