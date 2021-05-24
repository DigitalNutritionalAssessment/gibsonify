import 'package:flutter/material.dart';

class LoginProvider extends InheritedWidget {
  final Function validationErrorCallback;
  final Widget child;

  LoginProvider({this.validationErrorCallback, this.child})
      : super(child: child);

  static LoginProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: LoginProvider); //changed from inheritfrom, and added aspect:

  @override
  bool updateShouldNotify(LoginProvider oldWidget) =>
      validationErrorCallback != oldWidget.validationErrorCallback;
}
