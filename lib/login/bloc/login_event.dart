part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmployeeNameChanged extends LoginEvent {
  final String employeeName;

  const EmployeeNameChanged({required this.employeeName});

  @override
  List<Object> get props => [employeeName];
}

class EmployeeIdChanged extends LoginEvent {
  final String employeeId;

  const EmployeeIdChanged({required this.employeeId});

  @override
  List<Object> get props => [employeeId];
}

class EmployeeIsSupervisorChanged extends LoginEvent {
  final bool employeeIsSupervisor;

  const EmployeeIsSupervisorChanged({required this.employeeIsSupervisor});

  @override
  List<Object> get props => [employeeIsSupervisor];
}

class LoginInfoSaved extends LoginEvent {
  const LoginInfoSaved();

  @override
  List<Object> get props => [];
}

class LoginInfoLoaded extends LoginEvent {
  const LoginInfoLoaded();

  @override
  List<Object> get props => [];
}
