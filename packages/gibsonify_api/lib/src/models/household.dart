import 'package:gibsonify_api/src/models/respondent.dart';
import 'package:isar/isar.dart';

part 'household.g.dart';

@Collection()
class Household {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  final String householdId;
  final DateTime sensitizationDate;
  final String geoLocation;
  final String comments;
  final List<Respondent> respondents = [];

  Household({
    required this.householdId,
    required this.sensitizationDate,
    required this.geoLocation,
    required this.comments,
  });
}
