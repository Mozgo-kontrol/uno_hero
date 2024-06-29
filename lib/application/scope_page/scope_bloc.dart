import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/player_entity.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/score_board_item.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';
import '../../presantation/create_tournament_page/scope_screen_arguments.dart';

part 'scope_event.dart';

part 'scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  final ManageTournamentsUsecases usecases;
  late TournamentEntity tournament;

  ScopeBloc({required this.usecases}) : super(ScopeInitialState()) {
    on<LoadScopesEvent>(_initScopes);
    on<UpdatePlayerScoreEvent>(_updatePlayerScores);
  }

  Future<void> _initScopes(
      LoadScopesEvent event, Emitter<ScopeState> emit) async {
    emit(OnLoadingDataState());
    final tournamentId = event.arguments.tournamentId;
      tournament = await usecases.findTournamentById(tournamentId);
    emit(LoadedDataState(
        listOfScoresBoardItems: _initScoresBoardItems(tournament),
        tournamentTitle: tournament.title));
  }


  Future<void> _updatePlayerScores(
      UpdatePlayerScoreEvent event, Emitter<ScopeState> emit) async {
    emit(OnLoadingDataState());
    print("UpdatePlayerScoreEvent ${event.mapOfPlayersScores.toString()}");

    List<PlayerEntity> players = [];
    for (var player in tournament.players) {
      int newPlayersScore = event.mapOfPlayersScores[player.id] ?? 0;
      player.score = player.score + newPlayersScore;
      players.add(player);
    }
     tournament.players = players;

     usecases.updateTournament(tournament);

    emit(LoadedDataState(
        listOfScoresBoardItems: _initScoresBoardItems(tournament),
        tournamentTitle: tournament.title));
  }

  List<ScoreBoardItem> _initScoresBoardItems(TournamentEntity tournament) {
    int position = 1;
    List<ScoreBoardItem> list = [];
    List<PlayerEntity> sortedData = tournament.players;
    sortPlayersByScore(sortedData);
    for (var player in sortedData) {
      list.add(ScoreBoardItem(
          playerId: player.id,
          score: player.score,
          playerName: convertPlayerName(player.name),
          currentPosition: position++));
    }
    print("initScoresForPlayers $list");
    return list;
  }

  void sortPlayersByScore(List<PlayerEntity> list){
    list.sort((a, b) => a.score.compareTo(b.score));
  }

  String convertPlayerName(String name){
    return name.length<=9 ? name : "${name.substring(0, 9)}..";
  }
}
