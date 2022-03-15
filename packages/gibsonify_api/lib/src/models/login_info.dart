import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class LoginInfo extends Equatable {
  LoginInfo({this.employeeName, this.employeeId, String? id})
      : id = id ?? const Uuid().v4();

  final String? employeeName;
  final String? employeeId;
  final String id;

  LoginInfo copyWith({String? employeeName, String? employeeId, String? id}) {
    return LoginInfo(
        employeeName: employeeName ?? this.employeeName,
        employeeId: employeeId ?? this.employeeId,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props => [employeeName, employeeId, id];

  LoginInfo.fromJson(Map<String, dynamic> json)
      : employeeName = json['employeeName'],
        employeeId = json['employeeId'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['employeeName'] = employeeName;
    data['employeeId'] = employeeId;
    data['id'] = id;
    return data;
  }
}
