import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

class Probe extends Equatable {
  Probe(
      {this.name,
      this.checked = false,
      this.answer,
      // TODO: why does this need to be a dictionary with uuids?
      List<Map<String, dynamic>>? probeOptions}) // TODO: rename to `options`
      : probeOptions = probeOptions ??
            [
              {'option': 'Yes', 'id': const Uuid().v4()},
              {'option': 'No', 'id': const Uuid().v4()}
            ];

  final String? name;
  final bool checked;
  final String? answer;
  final List<Map<String, dynamic>> probeOptions;

  String probeNameDisplay() {
    if (isFieldNotNullAndNotEmpty(name)) {
      return name!;
    }
    return 'Unnamed Probe';
  }

  List<String> optionsList() {
    final List<String> options = [];
    for (Map<String, dynamic> option in probeOptions) {
      options.add(option['option'] ?? '');
    }
    return options;
  }

  bool standardAnswer() {
    if (answer == optionsList()[0] || answer == null || answer == '') {
      return true;
    }
    return false;
  }

  Probe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        checked = json['checked'] == 'true' ? true : false,
        answer = json['answer'],
        probeOptions =
            List<Map<String, dynamic>>.from(jsonDecode(json['probeOptions']));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['checked'] = checked.toString();
    data['answer'] = answer;
    data['probeOptions'] = jsonEncode(probeOptions);
    return data;
  }

  String toCsv() {
    // TODO: these are actually probe options, the import/export format is wrong
    String probeAnswers = '';
    for (String probeOption in optionsList()) {
      probeAnswers += probeOption + ' + ';
    }
    probeAnswers =
        probeAnswers.substring(0, probeAnswers.length - ' + '.length);

    return '"$name","$probeAnswers"';
  }

  Probe copyWith(
      {String? name,
      bool? checked,
      String? answer,
      List<Map<String, dynamic>>? probeOptions,
      String? id}) {
    return Probe(
        name: name ?? this.name,
        checked: checked ?? this.checked,
        answer: answer ?? this.answer,
        probeOptions: probeOptions ?? this.probeOptions);
  }

  @override
  List<Object?> get props => [name, checked, answer, probeOptions];
}
