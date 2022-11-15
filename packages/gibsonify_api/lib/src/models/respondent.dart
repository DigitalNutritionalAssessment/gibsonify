import 'package:isar/isar.dart';

part 'respondent.g.dart';

@Embedded()
class Respondent {
  String? respondentName;
  String? respondentCountryCode;
  String? respondentTelNumberPrefix;
  String? respondentTelNumber;
  String? comments;
}
