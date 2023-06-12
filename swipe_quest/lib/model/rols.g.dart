// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rols.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RolsAdapter extends TypeAdapter<Rols> {
  @override
  final int typeId = 3;

  @override
  Rols read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rols(
      fields[0] as String,
      fields[1] as int,
      fields[2] as Die,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Rols obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.advantage)
      ..writeByte(2)
      ..write(obj.dice)
      ..writeByte(3)
      ..write(obj.times);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RolsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rols _$RolsFromJson(Map<String, dynamic> json) => Rols(
      json['name'] as String,
      json['advantage'] as int,
      $enumDecode(_$DieEnumMap, json['dice']),
      json['times'] as int,
    );

Map<String, dynamic> _$RolsToJson(Rols instance) => <String, dynamic>{
      'name': instance.name,
      'advantage': instance.advantage,
      'dice': _$DieEnumMap[instance.dice]!,
      'times': instance.times,
    };

const _$DieEnumMap = {
  Die.d2: 0,
  Die.d4: 1,
  Die.d6: 2,
  Die.d8: 3,
  Die.d10: 4,
  Die.d12: 5,
  Die.d20: 6,
};
