import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:gibsonify_api/gibsonify_api.dart';

part 'recipe_probe.g.dart';

@JsonSerializable()
@HiveType(typeId: 12)
class ProbeOption extends Equatable {
  ProbeOption({this.option, this.id = ''});

  @HiveField(0)
  final String? option;
  @HiveField(1)
  final String id;

  static List<ProbeOption> defaults() {
    final List<ProbeOption> options = [];
    options.add(ProbeOption(option: 'Yes', id: Uuid().v4()));
    options.add(ProbeOption(option: 'No', id: Uuid().v4()));
    return options;
  }

  factory ProbeOption.fromJson(Map<String, dynamic> json) =>
      _$ProbeOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ProbeOptionToJson(this);

  ProbeOption copyWith({String? option, String? id}) {
    return ProbeOption(option: option ?? this.option, id: id ?? this.id);
  }

  @override
  List<Object?> get props => [option, id];
}

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 11)
class Probe extends Equatable {
  Probe(
      {this.name,
      this.checked = false,
      this.answer,
      this.probeOptions = const []});

  @HiveField(0)
  final String? name;
  @HiveField(1)
  final bool checked;
  @HiveField(2)
  final String? answer;
  @HiveField(3)
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

  factory Probe.fromJson(Map<String, dynamic> json) => _$ProbeFromJson(json);

  Map<String, dynamic> toJson() => _$ProbeToJson(this);

  // Probe.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       checked = json['checked'] == 'true' ? true : false,
  //       answer = json['answer'],
  //       probeOptions = _jsonDecodeProbeOptions(json['probeOptions']);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['name'] = name;
  //   data['checked'] = checked.toString();
  //   data['answer'] = answer;
  //   data['probeOptions'] = jsonEncode(probeOptions);
  //   return data;
  // }

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
  List<Object?> get props => [name, checked, answer, probeOptions];
}

List<ProbeOption> _jsonDecodeProbeOptions(jsonEncodedProbeOptions) {
  List<dynamic> partiallyDecodedProbeOptions =
      jsonDecode(jsonEncodedProbeOptions);
  List<ProbeOption> fullyDecodedProbeOptions = List<ProbeOption>.from(
      partiallyDecodedProbeOptions.map((x) => ProbeOption.fromJson(x)));
  return fullyDecodedProbeOptions;
}
