// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rolHistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RolHistoryAdapter extends TypeAdapter<RolHistory> {
  @override
  final int typeId = 2;

  @override
  RolHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RolHistory(
      fields[0] as String,
      fields[1] as int,
      (fields[2] as List).cast<int>(),
      fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RolHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.advantage)
      ..writeByte(2)
      ..write(obj.values)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RolHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolHistory _$RolHistoryFromJson(Map<String, dynamic> json) => RolHistory(
      json['name'] as String,
      json['advantage'] as int,
      (json['values'] as List<dynamic>).map((e) => e as int).toList(),
      DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$RolHistoryToJson(RolHistory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'advantage': instance.advantage,
      'values': instance.values,
      'dateTime': instance.dateTime.toIso8601String(),
    };
