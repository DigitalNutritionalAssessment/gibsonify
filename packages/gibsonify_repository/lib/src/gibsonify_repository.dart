import 'package:gibsonify_repository/gibsonify_repository.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

/// Repository that handles requests for GibsonsForms and Recipes
class GibsonifyRepository {
  final GibsonifyApi _gibsonifyApi;

  const GibsonifyRepository({required GibsonifyApi gibsonifyApi})
      : _gibsonifyApi = gibsonifyApi;

  // TODO: Implement that if a Gibsons Form with same Id already exists it will
  // be replaced, otherwise this form is appended to list of saved forms
  Future<void> saveForm(GibsonsForm gibsonsForm) =>
      _gibsonifyApi.saveForm(gibsonsForm);

  // TODO: implement loading of multiple GibsonsForms - either have just one
  // method loadForms that loads all of them, or also a method
  // loadForm(String id) that only loads one form with matching UUID
  GibsonsForm loadForm() => _gibsonifyApi.loadForm();

  // TODO: Implement deletion of Forms based on their UUID
  // deleteForm(String id)
}
