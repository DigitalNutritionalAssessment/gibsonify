part of 'import_export_bloc.dart';

abstract class ImportExportEvent extends Equatable {
  const ImportExportEvent();

  @override
  List<Object> get props => [];
}

class DataSavedToDevice extends ImportExportEvent {
  const DataSavedToDevice();

  @override
  List<Object> get props => [];
}

class DataShared extends ImportExportEvent {
  const DataShared();

  @override
  List<Object> get props => [];
}
