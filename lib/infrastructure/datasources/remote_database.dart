import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uno_notes/application/tournament_page/tournament_bloc.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';

abstract class RemoteDataSource{


  ///request a random advice from free api
  ///throws a server-exception if response
  Future <List<TournamentEntity>>  getAllTournamentsFromApi();
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity);
  Future <int> getNextTournamentId();
}

class RemoteDataSourceImpl implements RemoteDataSource {

  final Box<TournamentEntity> _box;
  RemoteDataSourceImpl(this._box);

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() {
    // TODO: implement getAllTournamentsFromApi
    if(_box.values.length>=6||_box.values.isEmpty){
      _box.clear();
      //_box.addAll(initMockTournaments());
    }
    List<TournamentEntity> result=[];

    for (var element in _box.values) { result.add(element);}
     print("getAllTournaments $result");
      return Future.value(result);
  }

  @override
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity) {
    _box.add(tournamentEntity);
    print("added new tournament to db $tournamentEntity");
    print("in db last ${_box.values.last}");
    return  Future.value(_box.values.last);
  }
  @override
  Future <int> getNextTournamentId() {
    if(_box.values.isEmpty){
      return Future.value(1);
    }
    return Future.value(_box.values.last.id+1);
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
