import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/score_board_item.dart';
import '../../domain/entities/score_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';
import '../../presantation/create_tournament_page/scope_screen_arguments.dart';

part 'scope_event.dart';

part 'scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  final ManageTournamentsUsecases usecases;

  ScopeBloc({required this.usecases}) : super(ScopeInitialState()) {
    on<LoadScopesEvent>(_initScopes);

    on<RefreshScopesEvent>(_refreshScopes);
  }

  Future<void> _initScopes(
      LoadScopesEvent event, Emitter<ScopeState> emit) async {
    emit(OnLoadingDataState());
    int tournamentId = event.arguments.tournamentId;
    TournamentEntity tournament =
        await usecases.findTournamentById(tournamentId);


    emit(LoadedDataState(
        listOfScoresBoardItems: _initScoresBoardItems(tournament),
        tournamentName: tournament.name,
        mapOfScoresPlayer: tournament.mapOfScores));
  }

  Future<void> _refreshScopes(
      RefreshScopesEvent event, Emitter<ScopeState> emit) async {
    emit(OnLoadingDataState());
    int tournamentId = 1;//TODO inmpement Refresh method
    TournamentEntity tournament =
    await usecases.findTournamentById(tournamentId);
    emit(LoadedDataState(
        listOfScoresBoardItems: _initScoresBoardItems(tournament),
        mapOfScoresPlayer: tournament.mapOfScores,
        tournamentName: tournament.name));
  }

  List<ScoreBoardItem> _initScoresBoardItems(TournamentEntity tournament) {
    int position = 1;
    List<ScoreBoardItem> list = [];
    for (var player in tournament.players) {

      list.add(ScoreBoardItem(
          playerId: player.id,
          score: tournament.mapOfScores[player.id]?.score ?? 0,
          playerName: convertPlayerName(player.name),
          currentPosition: position++));
    }
    print("initScoresForPlayers $list");
    return list;
  }

  List<ScoreBoardItem> _initMapOfScoresForPlayers(TournamentEntity tournament) {
    int position = 1;
    Map<int, ScoreEntity> mapOfScores = HashMap();
    List<ScoreBoardItem> list = [];

    int scoreId = 1;
    for (var player in tournament.players) {
      mapOfScores.putIfAbsent(player.id, ()=> ScoreEntity(id: scoreId++, score: 0));
    }

    for (var element in tournament.players) {
      list.add(ScoreBoardItem(
          playerId: element.id,
          score: 0,
          playerName: convertPlayerName(element.name),
          currentPosition: position++));
    }
    print("initScoresForPlayers $list");
    return list;
  }

  String convertPlayerName(String name){
    return name.length<=9 ? name : "${name.substring(0, 9)}..";
  }
}
