import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata.g.dart';

@JsonSerializable()
@HiveType(typeId: 15)
class Metadata extends Equatable {
  @HiveField(0)
  final DateTime createdAt;
  @HiveField(1)
  final String createdBy;
  @HiveField(2)
  final DateTime lastModifiedAt;
  @HiveField(3)
  final String lastModifiedBy;

  const Metadata({
    required this.createdAt,
    required this.createdBy,
    required this.lastModifiedAt,
    required this.lastModifiedBy,
  });

  Metadata.create({
    required String createdBy,
  }) : this(
          createdAt: DateTime.now(),
          createdBy: createdBy,
          lastModifiedAt: DateTime.now(),
          lastModifiedBy: createdBy,
        );

  Metadata modify({
    required String lastModifiedBy,
  }) =>
      copyWith(
        lastModifiedBy: lastModifiedBy,
        lastModifiedAt: DateTime.now(),
      );

  Metadata copyWith(
      {DateTime? createdAt,
      String? createdBy,
      DateTime? lastModifiedAt,
      String? lastModifiedBy}) {
    return Metadata(
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
    );
  }

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);

  @override
  List<Object> get props => [
        createdAt,
        createdBy,
        lastModifiedAt,
        lastModifiedBy,
      ];
}
