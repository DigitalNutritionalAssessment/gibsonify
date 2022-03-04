import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';

/// Custom pop function used in `WillPopScope`'s `onWillPop` argument in
/// Collection screens to override the Android Back button and swipe gesture to
/// save current Collection changes and reload all Collections to HomeBloc.
Future<bool> collectionPop(BuildContext context) async {
  // TODO: refactor this to a WillPopScope wrapper widget called
  // CollectionPopScreen that can be used in each screen in Collection instead
  // of always having to wrap the `build` return widget in WillPopScope
  context.read<CollectionBloc>().add(const GibsonsFormSaved());
  context.read<HomeBloc>().add(const GibsonsFormsLoaded());
  Navigator.of(context).pop(true);
  return true;
}
