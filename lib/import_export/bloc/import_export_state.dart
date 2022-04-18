part of 'import_export_bloc.dart';

enum DataSaveStatus {
  notRequested,
  noData,
  noPermissionToSaveFiles,
  success,
  error
}

enum DataShareStatus { notRequested, noData, success, error }

class ImportExportState extends Equatable {
  const ImportExportState(
      {this.dataSaveStatus = DataSaveStatus.notRequested,
      this.dataShareStatus = DataShareStatus.notRequested,
      this.exportedGibsonsFormsNumber = 0,
      this.exportedRecipesNumber = 0});

  final DataSaveStatus dataSaveStatus;
  final DataShareStatus dataShareStatus;
  final int exportedGibsonsFormsNumber;
  final int exportedRecipesNumber;

  ImportExportState copyWith(
      {DataSaveStatus? dataSaveStatus,
      DataShareStatus? dataShareStatus,
      int? exportedGibsonsFormsNumber,
      int? exportedRecipesNumber}) {
    return ImportExportState(
        dataSaveStatus: dataSaveStatus ?? this.dataSaveStatus,
        dataShareStatus: dataShareStatus ?? this.dataShareStatus,
        exportedGibsonsFormsNumber:
            exportedGibsonsFormsNumber ?? this.exportedGibsonsFormsNumber,
        exportedRecipesNumber:
            exportedRecipesNumber ?? this.exportedRecipesNumber);
  }

  @override
  List<Object> get props => [
        dataSaveStatus,
        dataShareStatus,
        exportedGibsonsFormsNumber,
        exportedRecipesNumber
      ];
}
