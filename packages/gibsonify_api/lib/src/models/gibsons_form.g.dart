// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gibsons_form.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GibsonsFormAdapter extends TypeAdapter<GibsonsForm> {
  @override
  final int typeId = 5;

  @override
  GibsonsForm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GibsonsForm(
      id: fields[0] as String,
      surveyId: fields[1] as String?,
      recallDay: fields[2] as String?,
      interviewDate: fields[3] as String?,
      interviewStartTime: fields[4] as String?,
      physioStatus: fields[5] as PhysioStatus,
      pictureChartCollected: fields[6] as String?,
      pictureChartNotCollectedReason: fields[7] as String?,
      interviewEndTime: fields[8] as String?,
      interviewFinishedInOneVisit: fields[9] as String?,
      secondInterviewVisitDate: fields[10] as String?,
      secondVisitReason: fields[11] as String?,
      interviewOutcome: fields[12] as String?,
      interviewOutcomeNotCompletedReason: fields[13] as String?,
      comments: fields[14] as String?,
      finished: fields[15] as bool,
      foodItems: (fields[16] as List).cast<FoodItem>(),
      metadata: fields[17] as Metadata,
    );
  }

  @override
  void write(BinaryWriter writer, GibsonsForm obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.surveyId)
      ..writeByte(2)
      ..write(obj.recallDay)
      ..writeByte(3)
      ..write(obj.interviewDate)
      ..writeByte(4)
      ..write(obj.interviewStartTime)
      ..writeByte(5)
      ..write(obj.physioStatus)
      ..writeByte(6)
      ..write(obj.pictureChartCollected)
      ..writeByte(7)
      ..write(obj.pictureChartNotCollectedReason)
      ..writeByte(8)
      ..write(obj.interviewEndTime)
      ..writeByte(9)
      ..write(obj.interviewFinishedInOneVisit)
      ..writeByte(10)
      ..write(obj.secondInterviewVisitDate)
      ..writeByte(11)
      ..write(obj.secondVisitReason)
      ..writeByte(12)
      ..write(obj.interviewOutcome)
      ..writeByte(13)
      ..write(obj.interviewOutcomeNotCompletedReason)
      ..writeByte(14)
      ..write(obj.comments)
      ..writeByte(15)
      ..write(obj.finished)
      ..writeByte(16)
      ..write(obj.foodItems)
      ..writeByte(17)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GibsonsFormAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhysioStatusAdapter extends TypeAdapter<PhysioStatus> {
  @override
  final int typeId = 6;

  @override
  PhysioStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PhysioStatus.notApplicable;
      case 1:
        return PhysioStatus.pregnant;
      case 2:
        return PhysioStatus.lactatingH1;
      case 3:
        return PhysioStatus.lactatingH2;
      default:
        return PhysioStatus.notApplicable;
    }
  }

  @override
  void write(BinaryWriter writer, PhysioStatus obj) {
    switch (obj) {
      case PhysioStatus.notApplicable:
        writer.writeByte(0);
        break;
      case PhysioStatus.pregnant:
        writer.writeByte(1);
        break;
      case PhysioStatus.lactatingH1:
        writer.writeByte(2);
        break;
      case PhysioStatus.lactatingH2:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhysioStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
