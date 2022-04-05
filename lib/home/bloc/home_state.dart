part of 'home_bloc.dart';

enum GibsonsFormsExportStatus {
  notRequested,
  noCsvForms,
  noPermissionToSaveFile,
  externalSaveSuccess,
  internalSaveSuccess,
  error
}

class HomeState extends Equatable {
  const HomeState(
      {this.gibsonsForms = const [],
      this.collectionDuplicationMode = false,
      this.exportedGibsonsFormsNumber,
      this.exportedRecipesNumber,
      this.lastInternalExportPath, // TODO: delete
      this.lastExternalExportPath, // TODO: delete
      this.gibsonsFormsExportStatus = GibsonsFormsExportStatus.notRequested});

  final List<GibsonsForm?> gibsonsForms;
  final bool collectionDuplicationMode;
  final int? exportedGibsonsFormsNumber;
  // TODO: exportedRecipesNumber is needed to display snackbars with both
  // recipe and gibsonsforms exported numbers while listening to only one bloc
  final int? exportedRecipesNumber;
  final String? lastExternalExportPath;
  final String? lastInternalExportPath;
  final GibsonsFormsExportStatus gibsonsFormsExportStatus;

  HomeState copyWith(
      {List<GibsonsForm?>? gibsonsForms,
      bool? collectionDuplicationMode,
      int? exportedGibsonsFormsNumber,
      int? exportedRecipesNumber,
      String? lastExternalExportPath,
      String? lastInternalExportPath,
      GibsonsFormsExportStatus? gibsonsFormsExportStatus}) {
    return HomeState(
      gibsonsForms: gibsonsForms ?? this.gibsonsForms,
      collectionDuplicationMode:
          collectionDuplicationMode ?? this.collectionDuplicationMode,
      exportedGibsonsFormsNumber:
          exportedGibsonsFormsNumber ?? this.exportedGibsonsFormsNumber,
      exportedRecipesNumber:
          exportedRecipesNumber ?? this.exportedRecipesNumber,
      lastExternalExportPath:
          lastExternalExportPath ?? this.lastExternalExportPath,
      lastInternalExportPath:
          lastInternalExportPath ?? this.lastInternalExportPath,
      gibsonsFormsExportStatus:
          gibsonsFormsExportStatus ?? this.gibsonsFormsExportStatus,
    );
  }

  @override
  List<Object?> get props => [
        gibsonsForms,
        collectionDuplicationMode,
        exportedGibsonsFormsNumber,
        exportedRecipesNumber,
        lastExternalExportPath,
        lastInternalExportPath,
        gibsonsFormsExportStatus,
      ];
}
