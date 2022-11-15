import 'package:gibsonify_api/src/models/respondent.dart';
import 'package:isar/isar.dart';

part 'household.g.dart';

@Collection()
class Household {
  Id id = Isar.autoIncrement;
  String householdId = "";
  String sensitizationDate = "";
  String geoLocation = "";
  String comments = "";
  List<Respondent> respondents = [];
}
