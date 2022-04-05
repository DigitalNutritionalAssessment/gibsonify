import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:gibsonify/recipe/recipe.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GibsonifyRepository _gibsonifyRepository;

  HomeBloc({
    required GibsonifyRepository gibsonifyRepository,
  })  : _gibsonifyRepository = gibsonifyRepository,
        super(const HomeState()) {
    // TODO: implement a subscription to a stream of GibsonsForms
    on<GibsonsFormsLoaded>(_onGibsonsFormsLoaded);
    on<GibsonsFormDeleted>(_onGibsonsFormDeleted);
    on<CollectionDuplicationModeToggled>(_onCollectionDuplicationModeToggled);
    on<FinishedGibsonsFormsShared>(_onFinishedGibsonsFormsShared);
  }

  void _onGibsonsFormsLoaded(
      GibsonsFormsLoaded event, Emitter<HomeState> emit) async {
    List<GibsonsForm?> gibsonsFormsLoaded = _gibsonifyRepository.loadForms();
    emit(state.copyWith(gibsonsForms: gibsonsFormsLoaded));
  }

  void _onGibsonsFormDeleted(
      GibsonsFormDeleted event, Emitter<HomeState> emit) async {
    _gibsonifyRepository.deleteForm(event.id);
    // TODO: Find a more efficient implementation
    List<GibsonsForm?> gibsonsFormsLoaded = _gibsonifyRepository.loadForms();
    emit(state.copyWith(gibsonsForms: gibsonsFormsLoaded));
  }

  void _onCollectionDuplicationModeToggled(
      CollectionDuplicationModeToggled event, Emitter<HomeState> emit) {
    emit(state.copyWith(
        collectionDuplicationMode: !state.collectionDuplicationMode));
  }

  void _onFinishedGibsonsFormsShared(
      FinishedGibsonsFormsShared event, Emitter<HomeState> emit) async {
    int sharedGibsonsFormsNumber = state.gibsonsForms
        .where((gibsonsForm) => gibsonsForm != null && gibsonsForm.finished)
        .length;

    if (sharedGibsonsFormsNumber == 0) {
      emit(state.copyWith(
          gibsonsFormsExportStatus: GibsonsFormsExportStatus.noCsvForms,
          exportedGibsonsFormsNumber: sharedGibsonsFormsNumber));
      return;
    }

    String finishedGibsonsFormsCsv =
        _convertFinishedGibsonsFormsToCsv(state.gibsonsForms);

    try {
      final applicationDocumentsDirectory =
          await getApplicationDocumentsDirectory();

      String currentDateTime =
          DateFormat("yyyy-MM-dd-HH-mm-ss").format(DateTime.now());
      final collectionfilePath = '${applicationDocumentsDirectory.path}'
          '/collection-data-$currentDateTime.csv';
      final collectionfile = File(collectionfilePath);
      collectionfile.writeAsString(finishedGibsonsFormsCsv);

      emit(state.copyWith(
          gibsonsFormsExportStatus:
              GibsonsFormsExportStatus.internalSaveSuccess,
          exportedGibsonsFormsNumber: sharedGibsonsFormsNumber,
          lastInternalExportPath: collectionfilePath));
    } catch (e) {
      emit(state.copyWith(
          gibsonsFormsExportStatus: GibsonsFormsExportStatus.error,
          exportedGibsonsFormsNumber: sharedGibsonsFormsNumber));
    }
  }
}

String _convertFinishedGibsonsFormsToCsv(List<GibsonsForm?> gibsonsForms) {
  // TODO: move this string to the API and rename to GibsonsFormsCsvHeaders
  String finishedGibsonsFormsCsv =
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
  for (GibsonsForm? gibsonsForm in gibsonsForms) {
    if (gibsonsForm != null && gibsonsForm.finished) {
      finishedGibsonsFormsCsv = finishedGibsonsFormsCsv + gibsonsForm.toCsv();
    }
  }
  return finishedGibsonsFormsCsv;
}
