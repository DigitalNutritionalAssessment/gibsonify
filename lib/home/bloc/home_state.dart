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
      this.lastInternalExportPath,
      this.lastExternalExportPath,
      this.gibsonsFormsExportStatus = GibsonsFormsExportStatus.notRequested});

  final List<GibsonsForm?> gibsonsForms;
  final bool collectionDuplicationMode;
  final int? exportedGibsonsFormsNumber;
  final String? lastExternalExportPath;
  final String? lastInternalExportPath;
  final GibsonsFormsExportStatus gibsonsFormsExportStatus;

  HomeState copyWith(
      {List<GibsonsForm?>? gibsonsForms,
      bool? collectionDuplicationMode,
      int? exportedGibsonsFormsNumber,
      String? lastExternalExportPath,
      String? lastInternalExportPath,
      GibsonsFormsExportStatus? gibsonsFormsExportStatus}) {
    return HomeState(
        gibsonsForms: gibsonsForms ?? this.gibsonsForms,
        collectionDuplicationMode:
            collectionDuplicationMode ?? this.collectionDuplicationMode,
        exportedGibsonsFormsNumber:
            exportedGibsonsFormsNumber ?? this.exportedGibsonsFormsNumber,
        lastExternalExportPath:
            lastExternalExportPath ?? this.lastExternalExportPath,
        lastInternalExportPath:
            lastInternalExportPath ?? this.lastInternalExportPath,
        gibsonsFormsExportStatus:
            gibsonsFormsExportStatus ?? this.gibsonsFormsExportStatus);
  }

  @override
  List<Object?> get props => [
        gibsonsForms,
        collectionDuplicationMode,
        exportedGibsonsFormsNumber,
        lastExternalExportPath,
        lastInternalExportPath,
        gibsonsFormsExportStatus
      ];
}
