
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';


abstract class LocalDataSource{
  ///request a random advice from free api
  ///throws a server-exception if response
  ///Tournaments data
  Future <List<TournamentEntity>>  getAllTournamentsFromApi();
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity);
  Future<TournamentEntity> findTournamentById(int id);
  Future <int> getNextTournamentId();
  Future<void> updateTournament(TournamentEntity tournamentEntity);
  Future<void> finishTournament(int id);
  Future<void> removeTournamentById(int id) async {}
  Future<List<TournamentEntity>> getAllActiveTournaments();
  Future<List<TournamentEntity>> getAllFinishedTournaments();

  ///PlayerMethods
  Future<List<PlayerEntity>> getAllPlayers();
  Future<void> removePlayerById(int id);
  Future<void> addNewPlayer(PlayerEntity player);
  Future<void> updatePlayer(PlayerEntity player);

}

class LocalDataSourceImpl implements LocalDataSource {

  final Box<TournamentEntity> _tournamentBox;
  final Box<PlayerEntity> _playerBox;
  LocalDataSourceImpl(this._tournamentBox, this._playerBox);

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() {
    List<TournamentEntity> result=[];
    for (var element in _tournamentBox.values) { result.add(element);}
     print("getAllTournaments $result");
      return Future.value(result);
  }

  @override
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity) async {
    await _tournamentBox.put(tournamentEntity.id, tournamentEntity);
    await _tournamentBox.flush();
    print("added new tournament to db $tournamentEntity");
    print("in db last ${_tournamentBox.values.last}");
    return  Future.value(_tournamentBox.values.last);
  }
  @override
  Future <int> getNextTournamentId() {
    if(_tournamentBox.values.isEmpty){
      return Future.value(1);
    }
    return Future.value(_tournamentBox.values.last.id+1);
  }

  @override
  Future<TournamentEntity> findTournamentById(int id) {
    TournamentEntity? tournament = _tournamentBox.get(id);
    if (tournament == null) {
      print('No tournament found for key $id');
    }
    return Future.value(tournament);
  }

  @override
  Future<void> updateTournament(TournamentEntity tournamentNew) async {
    if(_tournamentBox.isOpen) {
      await _tournamentBox.put(tournamentNew.id, tournamentNew);
      await _tournamentBox.flush();
      print("updated tournament data in db ${tournamentNew.id}");
    }

  }

  @override
  Future<void> finishTournament(int id) async {
    TournamentEntity? tournament = _tournamentBox.get(id);
    if (tournament != null) {
      tournament.finishGame();
      await _tournamentBox.put(id, tournament);
      await _tournamentBox.flush();

      debugPrint("Tournament id ${tournament.id} is finished : ${tournament.isFinished}");
      for (var player in tournament.listOfWinners) { debugPrint("WINNER : ${player.name}");}
    }
  }

  @override
  Future<void> removeTournamentById(int id) async {
    await _tournamentBox.delete(id);
    await _tournamentBox.flush();
  }
  ///Player method
  @override
  Future <void> addNewPlayer(PlayerEntity player) async {
    await _playerBox.put(player.id, player);
    print("added new player to db $player");
    await _playerBox.flush();
  }

  @override
  Future<List<PlayerEntity>> getAllPlayers() {
    List<PlayerEntity> result=[];
    for (var players in _playerBox.values) { result.add(players);}
    print("get all players $result");
    return Future.value(result);
  }

  @override
  Future<void> removePlayerById(int id) async {
    await _playerBox.delete(id);
    await _playerBox.flush();
  }

  @override
  Future<void> updatePlayer(PlayerEntity player) async {
    if(_playerBox.isOpen) {
      await _playerBox.put(player.id, player);
      await _playerBox.flush();
      print("updated player in db: $player");
    }
  }

  @override
  Future<List<TournamentEntity>> getAllActiveTournaments() {
    return Future.value(_tournamentBox.values.where((element) => !element.isFinished).toList());
  }

  @override
  Future<List<TournamentEntity>> getAllFinishedTournaments() {
    return Future.value(_tournamentBox.values.where((element) => element.isFinished).toList());
  }
}
