import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              initialValue: state.loginInfo.employeeName,
              decoration: InputDecoration(
                  icon: const Icon(Icons.format_list_numbered),
                  labelText: 'Employee Name',
                  helperText: 'Enter your name',
                  errorText:
                      (isFieldModifiedAndEmpty(state.loginInfo.employeeName))
                          ? 'Name field cannot be empty'
                          : null),
              onChanged: (value) {
                context
                    .read<LoginBloc>()
                    .add(EmployeeNameChanged(employeeName: value));
              },
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
            ),
            TextFormField(
              initialValue: state.loginInfo.employeeId,
              decoration: InputDecoration(
                  icon: const Icon(Icons.format_list_numbered),
                  labelText: 'Employee ID',
                  helperText: 'Enter your employee ID',
                  errorText:
                      (isFieldModifiedAndEmpty(state.loginInfo.employeeId))
                          ? 'Name field cannot be empty'
                          : null),
              onChanged: (value) {
                context
                    .read<LoginBloc>()
                    .add(EmployeeIdChanged(employeeId: value));
              },
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.characters,
            ),
            ListTile(
                title: const Text('Submit'),
                onTap: () => {
                      print(LoginInfo.fromJson(
                          jsonDecode(jsonEncode(state.loginInfo)))),
                      context.read<LoginBloc>().add(const LoginInfoSaved()),
                      // Navigator.pushNamed(context, PageRouter.home)
                    })
          ],
        );
      },
    );
  }
}
