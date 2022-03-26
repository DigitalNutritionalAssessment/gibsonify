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
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                key: Key(state.loginInfo.id),
                children: [
                  Image.asset('assets/images/gibsonify_name_styled.png'),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    initialValue: state.loginInfo.employeeName,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Employee Name',
                        helperText: 'Enter your name',
                        errorText: (isFieldModifiedAndEmpty(
                                state.loginInfo.employeeName))
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: state.loginInfo.employeeId,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Employee ID',
                        helperText: 'Enter your employee ID',
                        errorText: (isFieldModifiedAndEmpty(
                                state.loginInfo.employeeId))
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () => {
                            if (state.loginInfo.isLoginInfoValid())
                              {
                                context
                                    .read<LoginBloc>()
                                    .add(const LoginInfoSaved()),
                                Navigator.pushReplacementNamed(
                                    context, PageRouter.home)
                              }
                            else
                              {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Login information cannot be empty')),
                                  )
                              }
                          })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
