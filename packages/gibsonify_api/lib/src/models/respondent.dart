import 'package:gibsonify_api/src/models/anthropometrics.dart';
import 'package:gibsonify_api/src/models/gibsons_form.dart';
import 'package:isar/isar.dart';

part 'respondent.g.dart';

@Embedded()
class Respondent {
  final String name;
  final String phoneNumber;
  final String comments;
  final List<GibsonsForm> collections;
  final List<Anthropometrics> anthropometrics;

  Respondent({
    this.name = "",
    this.phoneNumber = "",
    this.comments = "",
    this.collections = const [],
    this.anthropometrics = const [],
  });

  Respondent copyWith({
    String? name,
    String? phoneNumber,
    String? comments,
    List<GibsonsForm>? collections,
    List<Anthropometrics>? anthropometrics,
  }) {
    return Respondent(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      comments: comments ?? this.comments,
      collections: collections ?? this.collections,
      anthropometrics: anthropometrics ?? this.anthropometrics,
    );
  }
}
