import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/src/models/models.dart';
import 'package:isar/isar.dart';

part 'household.g.dart';

@Collection(inheritance: false)
class Household extends Equatable {
  final Id id;
  @Index(unique: true)
  final String householdId;
  final DateTime sensitizationDate;
  final String geoLocation;
  final String comments;
  final List<Respondent> respondents;

  @override
  @ignore
  List<Object> get props => [
        householdId,
        sensitizationDate,
        geoLocation,
        comments,
        respondents,
      ];

  Household({
    this.id = Isar.autoIncrement,
    required this.householdId,
    required this.sensitizationDate,
    required this.geoLocation,
    required this.comments,
    this.respondents = const [],
  });

  copyWith({
    int? id,
    String? householdId,
    DateTime? sensitizationDate,
    String? geoLocation,
    String? comments,
    List<Respondent>? respondents,
  }) {
    return Household(
      id: id ?? this.id,
      householdId: householdId ?? this.householdId,
      sensitizationDate: sensitizationDate ?? this.sensitizationDate,
      geoLocation: geoLocation ?? this.geoLocation,
      comments: comments ?? this.comments,
      respondents: respondents ?? this.respondents,
    );
  }

  double getLat() {
    return double.parse(geoLocation.split(',')[0]);
  }

  double getLng() {
    return double.parse(geoLocation.split(',')[1]);
  }
}
