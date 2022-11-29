import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

part 'recipe_probe.g.dart';

@Embedded(inheritance: false)
class ProbeOption extends Equatable {
  ProbeOption({this.option, this.id = ''});

  final String? option;
  final String id;

  ProbeOption.fromJson(Map<String, dynamic> json)
      : option = json['option'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    data['id'] = id;
    return data;
  }

  ProbeOption copyWith({String? option, String? id}) {
    return ProbeOption(option: option ?? this.option, id: id ?? this.id);
  }

  @override
  @ignore
  List<Object?> get props => [option, id];
}

@Embedded(inheritance: false)
class Probe extends Equatable {
  Probe(
      {this.name,
      this.checked = false,
      this.answer,
      this.probeOptions = const []});

  final String? name;
  final bool checked;
  final String? answer;
  final List<ProbeOption> probeOptions;

  String probeNameDisplay() {
    if (isFieldNotNullAndNotEmpty(name)) {
      return name!;
    }
    return 'Unnamed probe';
  }

  List<String> optionsList() {
    final List<String> options = [];
    for (ProbeOption option in probeOptions) {
      options.add(option.option ?? '');
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
        probeOptions = _jsonDecodeProbeOptions(json['probeOptions']);

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
      List<ProbeOption>? probeOptions,
      String? id}) {
    return Probe(
        name: name ?? this.name,
        checked: checked ?? this.checked,
        answer: answer ?? this.answer,
        probeOptions: probeOptions ?? this.probeOptions);
  }

  @override
  @ignore
  List<Object?> get props => [name, checked, answer, probeOptions];
}

List<ProbeOption> _jsonDecodeProbeOptions(jsonEncodedProbeOptions) {
  List<dynamic> partiallyDecodedProbeOptions =
      jsonDecode(jsonEncodedProbeOptions);
  List<ProbeOption> fullyDecodedProbeOptions = List<ProbeOption>.from(
      partiallyDecodedProbeOptions.map((x) => ProbeOption.fromJson(x)));
  return fullyDecodedProbeOptions;
}
