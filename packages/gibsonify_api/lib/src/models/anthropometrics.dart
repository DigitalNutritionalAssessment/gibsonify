import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'anthropometrics.g.dart';

@Embedded(inheritance: false)
class Anthropometrics extends Equatable {
  Anthropometrics({
    this.date,
    this.weight,
    this.height,
    this.waist,
    this.armLength,
    this.handSpan,
  });

  final DateTime? date;
  final double? height;
  final double? weight;
  final double? waist;
  final double? armLength;
  final double? handSpan;

  @override
  @ignore
  List<Object?> get props => [
        date,
        height,
        weight,
        waist,
        armLength,
        handSpan,
      ];
}
