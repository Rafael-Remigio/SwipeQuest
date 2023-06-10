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
      (fields[2] as Map).cast<Die, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Rols obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.advantage)
      ..writeByte(2)
      ..write(obj.dice);
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
