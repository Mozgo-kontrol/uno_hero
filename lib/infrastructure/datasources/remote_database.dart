import 'dart:io';

import 'package:hive/hive.dart';
import 'package:uno_notes/application/tournament_page/tournament_bloc.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';

abstract class RemoteDataSource{


  ///request a random advice from free api
  ///throws a server-exception if response
  Future <List<TournamentEntity>>  getAllTournamentsFromApi();
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity);
  Future <TournamentEntity?> getTournamentById(int id);
  Future <TournamentEntity> getLastAddedTournament();
}

class RemoteDataSourceImpl implements RemoteDataSource {

  final Box<TournamentEntity> _box;
  RemoteDataSourceImpl(this._box);

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() {
    // TODO: implement getAllTournamentsFromApi
    List<TournamentEntity> result=[];
    for (var element in _box.values) { result.add(element);}
      return Future.value(result);
  }

  @override
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity) {
    _box.add(tournamentEntity);
    return  Future.value(_box.values.last);
  }

  @override
  Future<TournamentEntity?> getTournamentById(int id) {
    return Future.value(_box.getAt(id));
  }
  @override
  Future<TournamentEntity> getLastAddedTournament() {
    return  Future.value(_box.values.last);
  }


  List<TournamentEntity> initMockTournaments() {
    List<PlayerEntity> players = [
      PlayerEntity(id: 1, name: "Igor"),
      PlayerEntity(id: 2, name: "Hanna"),
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
