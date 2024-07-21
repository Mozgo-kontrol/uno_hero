// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TournamentEntityAdapter extends TypeAdapter<TournamentEntity> {
  @override
  final int typeId = 0;

  @override
  TournamentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TournamentEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      players: (fields[2] as List).cast<PlayerEntity>(),
    )
      ..isFinished = fields[3] as bool
      ..listOfWinners = (fields[4] as List).cast<PlayerEntity>()
      ..createdAt = fields[5] as DateTime
      ..finishedAt = fields[6] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, TournamentEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.players)
      ..writeByte(3)
      ..write(obj.isFinished)
      ..writeByte(4)
      ..write(obj.listOfWinners)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.finishedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
