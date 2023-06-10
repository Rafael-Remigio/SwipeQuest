// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'die.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DieAdapter extends TypeAdapter<Die> {
  @override
  final int typeId = 10;

  @override
  Die read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Die.d2;
      case 1:
        return Die.d4;
      case 2:
        return Die.d6;
      case 3:
        return Die.d8;
      case 4:
        return Die.d10;
      case 5:
        return Die.d12;
      case 6:
        return Die.d20;
      default:
        return Die.d2;
    }
  }

  @override
  void write(BinaryWriter writer, Die obj) {
    switch (obj) {
      case Die.d2:
        writer.writeByte(0);
        break;
      case Die.d4:
        writer.writeByte(1);
        break;
      case Die.d6:
        writer.writeByte(2);
        break;
      case Die.d8:
        writer.writeByte(3);
        break;
      case Die.d10:
        writer.writeByte(4);
        break;
      case Die.d12:
        writer.writeByte(5);
        break;
      case Die.d20:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
