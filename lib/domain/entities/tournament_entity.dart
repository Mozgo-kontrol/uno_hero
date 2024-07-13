import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uno_notes/domain/entities/player_entity.dart';

import '../../application/utils/utils.dart';

part 'tournament_entity.g.dart';

@HiveType(typeId: 0)
class TournamentEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  List<PlayerEntity> players = [];
  @HiveField(3)
  bool isFinished = false;
  @HiveField(4)
  List<PlayerEntity> listOfWinners = [];
  @HiveField(5)
  final DateTime createdAt = DateTime.now();
  @HiveField(6)
  DateTime? finishedAt;


  @override
  String toString() {
    return 'TournamentEntity{id: $id, title: $title, isFinished: $isFinished, players: $players, listOfWinners: ${listOfWinners.toString()}';
  }

  TournamentEntity({required this.id, required this.title, required this.players});

  void finishGame() {
    listOfWinners = findFirstThreeWinners(players);
    isFinished = true;
    finishedAt = DateTime.now();
  }

  List<PlayerEntity> findFirstThreeWinners(List<PlayerEntity> players) {
    int playerCount = players.length;
    if (players.isEmpty) {
      debugPrint("can not find first Three winner, because playersList is empty");
      return [];
    }

    players.sort((a, b) => a.score.compareTo(b.score));
    if (playerCount <= 2) {
      return players.sublist(0, playerCount);
    }
    else{
      return players.sublist(0, 3);
    }
  }

  String getFormatedCreateAt(){
    return Utils.dateFormatter(createdAt);
  }

}
