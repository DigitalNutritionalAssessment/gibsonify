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

  Stream<void> watchHouseholds() {
    return isar.households.watchLazy(fireImmediately: true);
  }

  Future<Household?> readHousehold(int id) async {
    return await isar.households.get(id);
  }

  Future<void> saveNewHousehold(Household household) async {
    await isar.writeTxn(() async {
      isar.households.put(household);
    });
  }

  Future<void> deleteHousehold(int id) async {
    await isar.writeTxn(() async {
      isar.households.delete(id);
    });
  }

  Future<void> saveNewRespondent(int id, Respondent respondent) async {
    await isar.writeTxn(() async {
      final household = await isar.households.get(id);
      household!.respondents.add(respondent);
      isar.households.put(household);
    });
  }
}
