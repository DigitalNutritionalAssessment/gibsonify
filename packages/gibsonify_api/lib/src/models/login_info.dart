import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class LoginInfo extends Equatable {
  LoginInfo(
      {this.employeeName,
      this.employeeId,
      this.employeeIsSupervisor = false,
      String? id})
      : id = id ?? const Uuid().v4();

  final String? employeeName;
  final String? employeeId;
  final bool? employeeIsSupervisor;
  // TODO: look into removing the id and fixing the resulting bug of TextForms
  // not rebuilding on app start
  final String id;

  LoginInfo copyWith(
      {String? employeeName,
      String? employeeId,
      bool? employeeIsSupervisor,
      String? id}) {
    return LoginInfo(
        employeeIsSupervisor: employeeIsSupervisor ?? this.employeeIsSupervisor,
        employeeName: employeeName ?? this.employeeName,
        employeeId: employeeId ?? this.employeeId,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props =>
      [employeeName, employeeId, employeeIsSupervisor, id];

  LoginInfo.fromJson(Map<String, dynamic> json)
      : employeeName = json['employeeName'],
        employeeId = json['employeeId'],
        employeeIsSupervisor = json['employeeIsSupervisor'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['employeeName'] = employeeName;
    data['employeeId'] = employeeId;
    data['employeeIsSupervisor'] = employeeIsSupervisor;
    data['id'] = id;
    return data;
  }

  bool isLoginInfoValid() {
    if (employeeName == null ||
        employeeName!.isEmpty ||
        employeeId == null ||
        employeeId!.isEmpty) {
      return false;
    }
    return true;
  }
}
