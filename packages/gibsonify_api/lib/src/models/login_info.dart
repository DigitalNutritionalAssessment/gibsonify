import 'package:equatable/equatable.dart';

class LoginInfo extends Equatable {
  LoginInfo({this.employeeName, this.employeeId});

  final String? employeeName;
  final String? employeeId;

  LoginInfo copyWith({String? employeeName, String? employeeId}) {
    return LoginInfo(
        employeeName: employeeName ?? this.employeeName,
        employeeId: employeeId ?? this.employeeId);
  }

  @override
  List<Object?> get props => [employeeName, employeeId];

  LoginInfo.fromJson(Map<String, dynamic> json)
      : employeeName = json['employeeName'],
        employeeId = json['employeeId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['employeeName'] = employeeName;
    data['employeeId'] = employeeId;
    return data;
  }
}
