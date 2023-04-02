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
      employeeNumber: fields[1] as String?,
      surveyId: fields[2] as String?,
      recallDay: fields[3] as String?,
      interviewDate: fields[4] as String?,
      interviewStartTime: fields[5] as String?,
      physioStatus: fields[6] as PhysioStatus,
      pictureChartCollected: fields[7] as String?,
      pictureChartNotCollectedReason: fields[8] as String?,
      interviewEndTime: fields[9] as String?,
      interviewFinishedInOneVisit: fields[10] as String?,
      secondInterviewVisitDate: fields[11] as String?,
      secondVisitReason: fields[12] as String?,
      interviewOutcome: fields[13] as String?,
      interviewOutcomeNotCompletedReason: fields[14] as String?,
      comments: fields[15] as String?,
      finished: fields[16] as bool,
      foodItems: (fields[17] as List).cast<FoodItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, GibsonsForm obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeNumber)
      ..writeByte(2)
      ..write(obj.surveyId)
      ..writeByte(3)
      ..write(obj.recallDay)
      ..writeByte(4)
      ..write(obj.interviewDate)
      ..writeByte(5)
      ..write(obj.interviewStartTime)
      ..writeByte(6)
      ..write(obj.physioStatus)
      ..writeByte(7)
      ..write(obj.pictureChartCollected)
      ..writeByte(8)
      ..write(obj.pictureChartNotCollectedReason)
      ..writeByte(9)
      ..write(obj.interviewEndTime)
      ..writeByte(10)
      ..write(obj.interviewFinishedInOneVisit)
      ..writeByte(11)
      ..write(obj.secondInterviewVisitDate)
      ..writeByte(12)
      ..write(obj.secondVisitReason)
      ..writeByte(13)
      ..write(obj.interviewOutcome)
      ..writeByte(14)
      ..write(obj.interviewOutcomeNotCompletedReason)
      ..writeByte(15)
      ..write(obj.comments)
      ..writeByte(16)
      ..write(obj.finished)
      ..writeByte(17)
      ..write(obj.foodItems);
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
