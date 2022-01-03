import 'dart:convert';

import 'package:gibsonify_api/gibsonify_api.dart';

/// API that handles requests for Gibson's form Collections and Recipes.
class GibsonifyApi {
  final SharedPreferences _sharedPreferences;
  GibsonifyApi({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const gibsonFormsKey = 'gibsonify_gibson_forms_key';

  Future<void> saveForm(GibsonsForm gibsonsForm) {
    String gibsonsFormEncoded = jsonEncode(gibsonsForm);

    // TODO: delete
    // print('API: Form successfuly jsonified, now saving to local storage!');

    return _sharedPreferences.setString(gibsonFormsKey, gibsonsFormEncoded);

    // TODO: implement saving multiple collections using setStringList
  }

  GibsonsForm loadForm() {
    // print('API: loading Form from local storage!'); // TODO: delete

    String? gibsonsFormRaw = _sharedPreferences.getString(gibsonFormsKey);

    if (gibsonsFormRaw == null) {
      // print('API: no form found, returning empty Form'); // TODO: delete
      GibsonsForm gibsonsForm = GibsonsForm();
      return gibsonsForm;
    } else {
      Map<String, dynamic> gibsonsFormDecoded = jsonDecode(gibsonsFormRaw);
      // print('API: Form successfuly decoded from json'); // TODO: delete
      return GibsonsForm.fromJson(gibsonsFormDecoded);
    }
  }
}
