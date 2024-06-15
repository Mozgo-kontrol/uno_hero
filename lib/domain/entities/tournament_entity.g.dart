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
      winner: fields[4] as Player,
      name: fields[1] as String,
      status: fields[2] as bool,
      id: fields[0] as int,
      players: (fields[3] as List).cast<Player>(),
    );
  }

  @override
  void write(BinaryWriter writer, TournamentEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.players)
      ..writeByte(4)
      ..write(obj.winner);
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
