import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:isar/isar.dart';

class IsarRepository {
  final Isar isar;

  IsarRepository({required this.isar});

  static Future<IsarRepository> create() async {
    final isar = await Isar.open([HouseholdSchema]);
    return IsarRepository(isar: isar);
  }

  Future<List<Household>> readHouseholds() async {
    return await isar.households.where().findAll();
  }
}
