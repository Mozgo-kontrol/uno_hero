import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/player_entity.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/score_board_item.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';
import '../../presantation/create_tournament_page/scope_screen_arguments.dart';
import '../utils/utils.dart';

part 'scope_event.dart';

part 'scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  final ManageTournamentsUsecases usecases;
  late TournamentEntity tournament;

  ScopeBloc({required this.usecases}) : super(ScopeInitialState()) {
    on<LoadScopesEvent>(_initScopes);
    on<UpdatePlayerScoreEvent>(_updatePlayerScores);


    on<FinishTournamentEvent>(_finishTournament);
  }

  Future<void> _initScopes(
      LoadScopesEvent event, Emitter<ScopeState> emit) async {
    emit(OnLoadingDataState());
    final tournamentId = event.arguments.tournamentId;
      tournament = await usecases.findTournamentById(tournamentId);
    emit(LoadedDataState(
        listOfScoresBoardItems: _initScoresBoardItems(tournament),
        tournamentTitle: tournament.title,
        isFinished: tournament.isFinished
    ));
  }

  Future<void> _finishTournament(
      FinishTournamentEvent event, Emitter<ScopeState> emit) async {
      await usecases.finishTournament(tournament.id);
      tournament = await usecases.findTournamentById(tournament.id);
      emit(LoadedDataState(
          listOfScoresBoardItems: _initScoresBoardItems(tournament),
          tournamentTitle: tournament.title,
          isFinished: tournament.isFinished
      ));
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
        tournamentTitle: tournament.title,
        isFinished: tournament.isFinished));
  }

  List<ScoreBoardItem> _initScoresBoardItems(TournamentEntity tournament) {
    int position = 1;
    List<ScoreBoardItem> list = [];
    List<PlayerEntity> sortedData = tournament.players;
    Utils.sortPlayersByScore(sortedData);
    for (var player in sortedData) {
      list.add(ScoreBoardItem(
          playerId: player.id,
          score: player.score,
          playerName: Utils.makeStringShorter(player.name, null),
          currentPosition: position++));
    }
    print("initScoresForPlayers $list");
    return list;
  }
}
