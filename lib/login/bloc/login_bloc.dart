import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GibsonifyRepository _gibsonifyRepository;

  LoginBloc({required GibsonifyRepository gibsonifyRepository})
      : _gibsonifyRepository = gibsonifyRepository,
        super(LoginState()) {
    on<EmployeeNameChanged>(_onEmployeeNameChanged);
    on<EmployeeIdChanged>(_onEmployeeIdChanged);
    on<LoginInfoSaved>(_onLoginInfoSaved);
    on<LoginInfoLoaded>(_onLoginInfoLoaded);
  }

  void _onEmployeeNameChanged(
      EmployeeNameChanged event, Emitter<LoginState> emit) {
    LoginInfo loginInfo =
        state.loginInfo.copyWith(employeeName: event.employeeName);

    emit(state.copyWith(loginInfo: loginInfo));
  }

  void _onEmployeeIdChanged(EmployeeIdChanged event, Emitter<LoginState> emit) {
    LoginInfo loginInfo =
        state.loginInfo.copyWith(employeeId: event.employeeId);

    emit(state.copyWith(loginInfo: loginInfo));
  }

  void _onLoginInfoSaved(LoginInfoSaved event, Emitter<LoginState> emit) async {
    LoginInfo loginInfo = state.loginInfo;
    await _gibsonifyRepository.saveLoginInfo(loginInfo);
    emit(state);
  }

  void _onLoginInfoLoaded(LoginInfoLoaded event, Emitter<LoginState> emit) {
    LoginInfo loginInfo = _gibsonifyRepository.loadLoginInfo();
    emit(state.copyWith(loginInfo: loginInfo));
  }
}
