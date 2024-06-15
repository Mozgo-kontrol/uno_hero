import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';

abstract class RemoteDataSource{


  ///request a random advice from free api
  ///throws a server-exception if response
  Future <List<TournamentEntity>>  getAllTournamentsFromApi();
}

class RemoteDataSourceImpl implements RemoteDataSource {

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() {
    // TODO: implement getAllTournamentsFromApi
    return Future.value(initTournament());
  }

  List<TournamentEntity> initTournament() {
    List<Player> players = [
      Player(id: 1, name: "Igor"),
      Player(id: 2, name: "Hanna"),
    ];
    return [TournamentEntity(
      name: "Tournament 1",
      winner: players[0],
      id: 1,
      status: false,
      players: players,
    ), TournamentEntity(
      name: "Tournament 2",
      winner: players[0],
      id: 2,
      status: true,
      players: players,
    ),
      TournamentEntity(
        name: "Tournament 3",
        winner: players[0],
        id: 3,
        status: true,
        players: players,
      )
    ];
  }
}
