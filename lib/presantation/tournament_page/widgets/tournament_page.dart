import 'package:flutter/material.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/entities/tournament_entity.dart';
import 'Tournament_list_widget.dart';


class TournamentPage extends StatelessWidget {

  late final List<Tournament> list;

  TournamentPage({super.key}){
    list = initTournament();
  }
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tournament",
          style: themeData.textTheme.headlineLarge,
        ),
      ),
      body: TournamentListWidget(tournaments: list,),
        floatingActionButton: FloatingActionButton(
      heroTag: "add",
      backgroundColor: Colors.deepOrangeAccent,
      onPressed: () => { print("floating action button")},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
    );
  }

  List<Tournament> initTournament() {

      List<Player> players  = [
        Player(id: 1, name: "Igor"),
        Player(id: 2, name: "Hanna"),
      ];
      return [Tournament(
        name: "Tournament 1",
        winner: players[0],
        id: 1,
        status: false,
        players: players,
      ),Tournament(
        name: "Tournament 2",
        winner: players[0],
        id: 2,
        status: true,
        players: players,
      ),
        Tournament(
          name: "Tournament 3",
          winner: players[0],
          id: 3,
          status: true,
          players: players,
        )];
  }
}