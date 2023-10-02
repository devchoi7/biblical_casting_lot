// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_def.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LotResultRecordAdapter extends TypeAdapter<LotResultRecord> {
  @override
  final int typeId = 1;

  @override
  LotResultRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LotResultRecord(
      date: fields[0] as String,
      time: fields[1] as String,
      title: fields[2] as String,
      items: fields[3] as String,
      selected: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LotResultRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.items)
      ..writeByte(4)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LotResultRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
