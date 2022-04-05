part of 'import_export_bloc.dart';

enum DataSaveStatus {
  notRequested,
  noData,
  noPermissionToSaveFiles,
  success,
  error
}

class ImportExportState extends Equatable {
  const ImportExportState(
      {this.dataSaveStatus = DataSaveStatus.notRequested,
      this.exportedGibsonsFormsNumber = 0,
      this.exportedRecipesNumber = 0});

  final DataSaveStatus dataSaveStatus;
  final int exportedGibsonsFormsNumber;
  final int exportedRecipesNumber;

  ImportExportState copyWith(
      {DataSaveStatus? dataSaveStatus,
      int? exportedGibsonsFormsNumber,
      int? exportedRecipesNumber}) {
    return ImportExportState(
        dataSaveStatus: dataSaveStatus ?? this.dataSaveStatus,
        exportedGibsonsFormsNumber:
            exportedGibsonsFormsNumber ?? this.exportedGibsonsFormsNumber,
        exportedRecipesNumber:
            exportedRecipesNumber ?? this.exportedRecipesNumber);
  }

  @override
  List<Object> get props =>
      [dataSaveStatus, exportedGibsonsFormsNumber, exportedRecipesNumber];
}
