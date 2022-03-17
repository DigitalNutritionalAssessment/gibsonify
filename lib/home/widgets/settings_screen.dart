import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/login/login.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, PageRouter.settingsHelp),
                icon: const Icon(Icons.help))
          ],
        ),
        body: const LoginTile());
  }
}

class LoginTile extends StatelessWidget {
  const LoginTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Edit user information'),
          subtitle: Text(
              'Employee Name: ${state.loginInfo.employeeName} \nEmployee ID: ${state.loginInfo.employeeId}'),
          onTap: () =>
              {Navigator.pushReplacementNamed(context, PageRouter.login)},
        ),
      );
    });
  }
}
