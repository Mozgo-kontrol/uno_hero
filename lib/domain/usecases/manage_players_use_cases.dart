import '../entities/player_entity.dart';
import '../repositories/player_repository.dart';

class ManagePlayersUseCases {

  final PlayerRepository playerRepository;
  ManagePlayersUseCases({required this.playerRepository});


  Future<void> addNewPlayer(PlayerEntity player) async {
    await playerRepository.addNewPlayer(player);
  }

  Future<List<PlayerEntity>> getAllPlayers() async {
    return await playerRepository.getAllPlayers();
  }

  Future<void> removePlayerById(int id) async {
    await playerRepository.removePlayerById(id);
  }

  Future<void> updatePlayer(PlayerEntity player) async {
    await playerRepository.updatePlayer(player);
  }
}