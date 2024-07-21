import 'package:uno_notes/domain/entities/player_entity.dart';

abstract class PlayerRepository{
  Future<List<PlayerEntity>> getAllPlayers();
  Future<void> removePlayerById(int id);
  Future<void>addNewPlayer(PlayerEntity player);
  Future<void> updatePlayer(PlayerEntity player);
}