import 'dart:io';

import 'package:hive/hive.dart';
import 'package:uno_notes/application/tournament_page/tournament_bloc.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';

abstract class RemoteDataSource{


  ///request a random advice from free api
  ///throws a server-exception if response
  Future <List<TournamentEntity>>  getAllTournamentsFromApi();
  void addTournamentToDB(TournamentEntity tournamentEntity);
  Future <TournamentEntity?> getTournamentById(int id);
}

class RemoteDataSourceImpl implements RemoteDataSource {

  final Box<TournamentEntity> _box;
  RemoteDataSourceImpl(this._box);

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() {
    // TODO: implement getAllTournamentsFromApi
    List<TournamentEntity> result =initMockTournaments();
    for (var element in _box.values) { result.add(element);}
      return Future.value(result);
  }

  @override
  void addTournamentToDB(TournamentEntity tournamentEntity) {
    _box.add(tournamentEntity);
  }

  @override
  Future<TournamentEntity?> getTournamentById(int id) {
    return Future.value(_box.getAt(id));

  }


  List<TournamentEntity> initMockTournaments() {
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
