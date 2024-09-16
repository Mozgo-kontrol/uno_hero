import 'package:uno_notes/domain/entities/player_entity.dart';

import '../../domain/repositories/player_repository.dart';
import '../datasources/local_database.dart';

class PlayerRepositoryImpl implements PlayerRepository{

  final LocalDataSource localDataSource;

  PlayerRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addNewPlayer(PlayerEntity player) async {
    await localDataSource.addNewPlayer(player);
  }

  @override
  Future<List<PlayerEntity>> getAllPlayers() async {
    return await localDataSource.getAllPlayers();
  }

  @override
  Future<void> removePlayerById(int id) async {
    await localDataSource.removePlayerById(id);
  }

  @override
  Future<void> updatePlayer(PlayerEntity player) async {
    await localDataSource.updatePlayer(player);
  }
}
