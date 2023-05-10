import 'package:gibsonify_api/src/models/anthropometrics.dart';
import 'package:gibsonify_api/src/models/gibsons_form.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'respondent.g.dart';

@HiveType(typeId: 2)
enum Sex {
  @HiveField(0)
  male,
  @HiveField(1)
  female
}

@HiveType(typeId: 3)
enum LiteracyLevel {
  @HiveField(0)
  illiterate,
  @HiveField(1)
  readWrite,
  @HiveField(2)
  readOnly,
  @HiveField(3)
  signatureOnly
}

@HiveType(typeId: 4)
enum Occupation {
  @HiveField(0)
  domestic,
  @HiveField(1)
  farmer,
  @HiveField(2)
  agriculturalLabour,
  @HiveField(3)
  casualLabour,
  @HiveField(4)
  mgnrega,
  @HiveField(5)
  salariedNonAgricultural,
  @HiveField(6)
  ownAccountEmployment,
  @HiveField(7)
  collectiveNonAgricultural,
  @HiveField(8)
  unableToWork,
  @HiveField(9)
  student,
  @HiveField(10)
  salariedGovernment,
  @HiveField(11)
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

@HiveType(typeId: 1)
class Respondent {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final DateTime dateOfBirth;
  @HiveField(4)
  final Sex sex;
  @HiveField(5)
  final LiteracyLevel literacyLevel;
  @HiveField(6)
  final Occupation occupation;
  @HiveField(7)
  final String comments;
  @HiveField(8)
  final Map<String, GibsonsForm> collections;
  @HiveField(9)
  final List<Anthropometrics> anthropometrics;

  Respondent({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.sex,
    required this.literacyLevel,
    required this.occupation,
    required this.comments,
    required this.collections,
    required this.anthropometrics,
  });

  Respondent.create(
      {required this.name,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.sex,
      required this.literacyLevel,
      required this.occupation,
      required this.comments,
      this.collections = const {},
      this.anthropometrics = const []})
      : id = Uuid().v4();

  Respondent copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    Sex? sex,
    LiteracyLevel? literacyLevel,
    Occupation? occupation,
    String? comments,
    Map<String, GibsonsForm>? collections,
    List<Anthropometrics>? anthropometrics,
  }) {
    return Respondent(
      id: id ?? this.id,
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
