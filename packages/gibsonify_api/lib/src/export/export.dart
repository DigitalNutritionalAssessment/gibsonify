import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export.g.dart';

@JsonSerializable(explicitToJson: true)
class GibsonifyExportFile {
  final List<Survey> surveys;
  final List<Household> households;
  final List<Recipe> recipes;
  final Metadata metadata;

  GibsonifyExportFile({
    required this.surveys,
    required this.households,
    required this.recipes,
    required this.metadata,
  });

  static fileName({required String employeeId}) {
    return 'gibsonify_export_${employeeId}_${DateFormat("yyyy-MM-dd-HH-mm-ss").format(DateTime.now())}.gib';
  }

  factory GibsonifyExportFile.fromJson(Map<String, dynamic> json) =>
      _$GibsonifyExportFileFromJson(json);

  Map<String, dynamic> toJson() => _$GibsonifyExportFileToJson(this);
}
