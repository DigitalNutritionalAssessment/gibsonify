import 'package:collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class FCTRepository {
  final Map<String, FoodCompositionTable> _fcts = {};

  FCTRepository(List<FoodCompositionTable> fcts) {
    for (final fct in fcts) {
      _fcts[fct.id] = fct;
    }
  }

  FoodCompositionTable _getFCT(String fctId) {
    final fct = _fcts[fctId];
    if (fct == null) {
      throw Exception('FCT $fctId not found');
    }
    return fct;
  }

  Iterable<String> getFCTIds() {
    return _fcts.keys;
  }

  Future<Map<String, FCTFoodGroup>> getFoodGroups(
      {required String fctId}) async {
    final fct = _getFCT(fctId);
    return await fct.getFoodGroups();
  }

  Future<FCTFoodItem?> getFoodItemById(
      {required String fctId, required String id}) async {
    final fct = _getFCT(fctId);
    return await fct.getFoodItem(id);
  }

  Future<Map<FCTFoodGroup, List<FCTFoodItem>>> search(
      {required String fctId, String? query}) async {
    final fct = _getFCT(fctId);
    final groups = await getFoodGroups(fctId: fctId);
    final search = await fct.search(query ?? '');
    final result =
        groupBy(search, (FCTFoodItem item) => groups[item.foodGroupId]!);

    return result;
  }
}
