import 'dart:collection';
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
  Future<TournamentEntity> findTournamentById(int id);
  Future <int> getNextTournamentId();
  Future<void> updateTournament(TournamentEntity tournamentEntity);
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
    _box.put(tournamentEntity.id, tournamentEntity);
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

  @override
  Future<TournamentEntity> findTournamentById(int id) {
    TournamentEntity? tournament = _box.get(id);
    if (tournament == null) {
      print('No tournament found for key $id');
    }
    return Future.value(tournament);
  }

  @override
  Future<void> updateTournament(TournamentEntity tournamentNew) async {
    if(_box.isOpen) {
    // Save the changes to the Hive box
      await _box.put(tournamentNew.id, tournamentNew);
      await _box.flush();
      print("updated tournament data in db ${tournamentNew.id}");
    }

  }
}
