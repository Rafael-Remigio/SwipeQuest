// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 0;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      name: fields[0] as String,
      system: fields[1] as String,
      rools: (fields[3] as List).cast<Rols>(),
      rolsHistory: (fields[4] as List).cast<RolHistory>(),
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.system)
      ..writeByte(3)
      ..write(obj.rools)
      ..writeByte(4)
      ..write(obj.rolsHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      system: json['system'] as String,
      rools: (json['rools'] as List<dynamic>)
          .map((e) => Rols.fromJson(e as Map<String, dynamic>))
          .toList(),
      rolsHistory: (json['rolsHistory'] as List<dynamic>)
          .map((e) => RolHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'system': instance.system,
      'rools': instance.rools,
      'rolsHistory': instance.rolsHistory,
    };
