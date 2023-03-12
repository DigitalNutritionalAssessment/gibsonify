import 'package:gibsonify_api/src/models/anthropometrics.dart';
import 'package:gibsonify_api/src/models/gibsons_form.dart';
import 'package:isar/isar.dart';

part 'respondent.g.dart';

enum Sex { male, female }

enum LiteracyLevel { illiterate, readWrite, readOnly, signatureOnly }

enum Occupation {
  domestic,
  farmer,
  agriculturalLabour,
  casualLabour,
  mgnrega,
  salariedNonAgricultural,
  ownAccountEmployment,
  collectiveNonAgricultural,
  unableToWork,
  student,
  salariedGovernment,
  other
}

String literacyLevelToString(LiteracyLevel literacyLevel) {
  switch (literacyLevel) {
    case LiteracyLevel.illiterate:
      return "Illiterate";
    case LiteracyLevel.readWrite:
      return "Literate - can read and write";
    case LiteracyLevel.readOnly:
      return "Literate - can read only";
    case LiteracyLevel.signatureOnly:
      return "Literate - can sign name";
  }
}

String occupationToString(Occupation occupation) {
  switch (occupation) {
    case Occupation.domestic:
      return "Domestic/care work, not paid";
    case Occupation.farmer:
      return "Farmer/cultivator/Livestock/Poultry";
    case Occupation.agriculturalLabour:
      return "Agricultural labourer";
    case Occupation.casualLabour:
      return "Non-agricultural casual labour";
    case Occupation.mgnrega:
      return "Mahatma Gandhi National Rural Employment Guarantee Act work";
    case Occupation.salariedNonAgricultural:
      return "Salaried worker (non-agricultural)";
    case Occupation.ownAccountEmployment:
      return "Own account employment (family or individual enterprise; non-agricultural)";
    case Occupation.collectiveNonAgricultural:
      return "Collectives/SHG employment/business, non-agricultural)";
    case Occupation.unableToWork:
      return "Unable to work due to health/age/disability";
    case Occupation.student:
      return "Student";
    case Occupation.salariedGovernment:
      return "Government salaried worker";
    case Occupation.other:
      return "Other";
  }
}

@Embedded()
class Respondent {
  final String name;
  final String phoneNumber;
  final DateTime? dateOfBirth;
  @Enumerated(EnumType.ordinal32)
  final Sex? sex;
  @Enumerated(EnumType.ordinal32)
  final LiteracyLevel? literacyLevel;
  @Enumerated(EnumType.ordinal32)
  final Occupation? occupation;
  final String comments;
  final List<GibsonsForm> collections;
  final List<Anthropometrics> anthropometrics;

  Respondent({
    this.name = "",
    this.phoneNumber = "",
    this.dateOfBirth,
    this.sex,
    this.literacyLevel,
    this.occupation,
    this.comments = "",
    this.collections = const [],
    this.anthropometrics = const [],
  });

  Respondent copyWith({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    Sex? sex,
    LiteracyLevel? literacyLevel,
    Occupation? occupation,
    String? comments,
    List<GibsonsForm>? collections,
    List<Anthropometrics>? anthropometrics,
  }) {
    return Respondent(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      literacyLevel: literacyLevel ?? this.literacyLevel,
      occupation: occupation ?? this.occupation,
      comments: comments ?? this.comments,
      collections: collections ?? this.collections,
      anthropometrics: anthropometrics ?? this.anthropometrics,
    );
  }
}
