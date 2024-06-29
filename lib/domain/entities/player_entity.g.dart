// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerEntityAdapter extends TypeAdapter<PlayerEntity> {
  @override
  final int typeId = 1;

  @override
  PlayerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      score: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
