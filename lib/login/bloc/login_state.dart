part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginInfo loginInfo;
  LoginState({LoginInfo? loginInfo}) : loginInfo = loginInfo ?? LoginInfo();

  LoginState copyWith({LoginInfo? loginInfo}) {
    return LoginState(loginInfo: loginInfo ?? this.loginInfo);
  }

  @override
  List<Object?> get props => [loginInfo];
}
