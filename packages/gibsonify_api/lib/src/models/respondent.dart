import 'package:isar/isar.dart';

part 'respondent.g.dart';

@Embedded()
class Respondent {
  final String name;
  final String phoneNumber;
  final String comments;

  Respondent({
    this.name = "",
    this.phoneNumber = "",
    this.comments = "",
  });
}
