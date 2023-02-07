import 'package:gibsonify_api/src/models/gibsons_form.dart';
import 'package:isar/isar.dart';

part 'respondent.g.dart';

@Embedded()
class Respondent {
  final String name;
  final String phoneNumber;
  final String comments;
  final List<GibsonsForm> collections;

  Respondent({
    this.name = "",
    this.phoneNumber = "",
    this.comments = "",
    this.collections = const [],
  });

  Respondent copyWith({
    String? name,
    String? phoneNumber,
    String? comments,
    List<GibsonsForm>? collections,
  }) {
    return Respondent(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      comments: comments ?? this.comments,
      collections: collections ?? this.collections,
    );
  }
}
