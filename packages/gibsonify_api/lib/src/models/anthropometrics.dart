import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anthropometrics.g.dart';

@JsonSerializable()
@HiveType(typeId: 13)
class Anthropometrics extends Equatable {
  Anthropometrics({
    required this.date,
    this.weight,
    this.height,
    this.waist,
    this.armLength,
    this.handSpan,
  });

  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final double? height;
  @HiveField(2)
  final double? weight;
  @HiveField(3)
  final double? waist;
  @HiveField(4)
  final double? armLength;
  @HiveField(5)
  final double? handSpan;

  @override
  List<Object?> get props => [
        date,
        height,
        weight,
        waist,
        armLength,
        handSpan,
      ];

  factory Anthropometrics.fromJson(Map<String, dynamic> json) =>
      _$AnthropometricsFromJson(json);

  Map<String, dynamic> toJson() => _$AnthropometricsToJson(this);
}
