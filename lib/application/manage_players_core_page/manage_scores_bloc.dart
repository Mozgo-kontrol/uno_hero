import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uno_notes/domain/entities/player_entity.dart';

import '../../domain/entities/score_entity.dart';
import '../../domain/entities/tournament_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';

part 'manage_scores_event.dart';

part 'manage_scores_state.dart';

class ManageScoresBloc extends Bloc<ManageScoresEvent, ManageScoresState> {
  final ManageTournamentsUsecases usecases;

  ManageScoresBloc({required this.usecases}) : super(InitialState()) {
    on<InitManageScoresEvent>(_onInitData);
    on<UpdatePlayerScoreEvent>(_onUpdateScores);
    // on<RemovePlayerEvent>(_onRemovePlayer);
    //  on<UpdateTitleEvent>(_onUpdateTitle);
    //  on<StartTournamentEvent>(_onStartTournament);
  }

  late final TournamentEntity _tournament;
  Map<PlayerEntity, ScoreEntity> _mapOfScores = HashMap();

  Future<void> _onInitData(
      InitManageScoresEvent event, Emitter<ManageScoresState> emit) async {
    emit(OnLoadingState());
    int tournamentId = event.tournamentId;
    _tournament = await usecases.findTournamentById(tournamentId);
    _mapOfScores = initScores(_tournament);
    emit(ShowScreenManageScoresState(mapOfScores: _mapOfScores));
  }

  Future<void> _onUpdateScores(
      UpdatePlayerScoreEvent event, Emitter<ManageScoresState> emit) async {
    int _playerId = event.playerId;
    int _newScore = event.score;

    PlayerEntity player =
        _mapOfScores.keys.firstWhere((player) => player.id == _playerId);
    ScoreEntity _score =  _mapOfScores[player] ?? ScoreEntity(id: 1, score: 0); //TODO
    _score.score = _score.score + _newScore;
    _mapOfScores.update(player, (value) => _score);
    emit(ShowScreenManageScoresState(mapOfScores: _mapOfScores));
  }

  Map<PlayerEntity, ScoreEntity> initScores(TournamentEntity tournament) {
    Map<PlayerEntity, ScoreEntity> mapOfScores = HashMap();
    int scoreId = 1;
    for (var player in tournament.players) {
      mapOfScores.putIfAbsent(
          player, () => ScoreEntity(id: scoreId++, score: 0));
    }
    return mapOfScores;
  }

  Map<PlayerEntity, ScoreEntity> updateScores(TournamentEntity tournament) {
    Map<PlayerEntity, ScoreEntity> mapOfScores = HashMap();
    int scoreId = 1;
    for (var player in tournament.players) {
      mapOfScores.putIfAbsent(
          player, () => ScoreEntity(id: scoreId++, score: 0));
    }
    return mapOfScores;
  }
}
