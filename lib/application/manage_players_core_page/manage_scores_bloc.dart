
import 'package:bloc/bloc.dart';

import 'package:uno_notes/domain/entities/player_entity.dart';

import '../../domain/entities/tournament_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';

part 'manage_scores_event.dart';

part 'manage_scores_state.dart';

class ManageScoresBloc extends Bloc<ManageScoresEvent, ManageScoresState> {
  final ManageTournamentsUsecases usecases;

  ManageScoresBloc({required this.usecases}) : super(InitialState()) {
    on<InitManageScoresEvent>(_onInitData);
    on<layerScoreEvent>(_onUpdateScores);
    // on<RemovePlayerEvent>(_onRemovePlayer);
    //  on<UpdateTitleEvent>(_onUpdateTitle);
    //  on<StartTournamentEvent>(_onStartTournament);
  }

  late final TournamentEntity _tournament;
  Future<void> _onInitData(
      InitManageScoresEvent event, Emitter<ManageScoresState> emit) async {
    emit(OnLoadingState());
    int tournamentId = event.tournamentId;
    _tournament = await usecases.findTournamentById(tournamentId);
    emit(ShowScreenManageScoresState(listOfPlayers: _tournament.players));
  }

  Future<void> _onUpdateScores(
      layerScoreEvent event, Emitter<ManageScoresState> emit) async {
    int _playerId = event.playerId;
    int _newScore = event.score;

    emit(ShowScreenManageScoresState(listOfPlayers: _tournament.players));
  }

}
