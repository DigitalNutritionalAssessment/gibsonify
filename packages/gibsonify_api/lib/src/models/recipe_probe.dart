import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class Probe extends Equatable {
  Probe(
      {this.probeName,
      this.checked = false,
      this.answer,
      List<Map<String, dynamic>>? probeOptions})
      : probeOptions = probeOptions ??
            [
              {'option': null, 'id': const Uuid().v4()},
              {'option': null, 'id': const Uuid().v4()}
            ];

  final String? probeName;
  final bool checked;
  final String? answer;
  final List<Map<String, dynamic>> probeOptions;

  List<String> optionsList() {
    final List<String> options = [];
    for (Map<String, dynamic> option in probeOptions) {
      options.add(option['option'] ?? '');
    }
    return options;
  }

  bool standardAnswer() {
    if (answer == optionsList()[0] || answer == null) {
      return true;
    }
    return false;
  }

  Probe.fromJson(Map<String, dynamic> json)
      : probeName = json['probeName'],
        checked = json['checked'] == 'true' ? true : false,
        answer = json['answer'],
        probeOptions =
            List<Map<String, dynamic>>.from(jsonDecode(json['probeOptions']));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['probeName'] = probeName;
    data['checked'] = checked.toString();
    data['answer'] = answer;
    data['probeOptions'] = jsonEncode(probeOptions);
    return data;
  }

  Probe copyWith(
      {String? probeName,
      bool? checked,
      String? answer,
      List<Map<String, dynamic>>? probeOptions,
      String? id}) {
    return Probe(
        probeName: probeName ?? this.probeName,
        checked: checked ?? this.checked,
        answer: answer ?? this.answer,
        probeOptions: probeOptions ?? this.probeOptions);
  }

  @override
  List<Object?> get props => [probeName, checked, answer, probeOptions];
}
