import 'package:gibsonify_api/gibsonify_api.dart';

class FCTRepository {
  final Map<String, FoodCompositionTable> _fcts = {};

  FCTRepository(List<FoodCompositionTable> fcts) {
    for (final fct in fcts) {
      _fcts[fct.id] = fct;
    }
  }

  Iterable<String> getFCTIds() {
    return _fcts.keys;
  }
}
