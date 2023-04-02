import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/src/models/models.dart';
import 'package:hive/hive.dart';

part 'household.g.dart';

@HiveType(typeId: 0)
class Household extends Equatable {
  @HiveField(0)
  final String householdId;
  @HiveField(1)
  final DateTime sensitizationDate;
  @HiveField(2)
  final String geoLocation;
  @HiveField(3)
  final String comments;
  @HiveField(4)
  final List<Respondent> respondents;

  @override
  List<Object> get props => [
        householdId,
        sensitizationDate,
        geoLocation,
        comments,
        respondents,
      ];

  Household({
    required this.householdId,
    required this.sensitizationDate,
    required this.geoLocation,
    required this.comments,
    this.respondents = const [],
  });

  copyWith({
    String? householdId,
    DateTime? sensitizationDate,
    String? geoLocation,
    String? comments,
    List<Respondent>? respondents,
  }) {
    return Household(
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
