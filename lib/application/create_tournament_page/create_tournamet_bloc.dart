import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';

part 'create_tournament_event.dart';
part 'create_tournament_state.dart';

class CreateTournamentBloc extends Bloc<CreateTournamentEvent, CreateTournamentState> {
  final ManageTournamentsUsecases usecases;
  CreateTournamentBloc({required this.usecases}) : super(CreateTournamentInitialState()) {
    on<CreateTournamentInitEvent>(_onInitData);
    on<AddPlayerEvent>(_onAddPlayer);
    on<RemovePlayerEvent>(_onRemovePlayer);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<StartTournamentEvent>(_onStartTournament);
  }

  late TournamentEntity tournament;
  List<PlayerEntity> _players = [];
  String _title = '';
  int tournamentId = 0;



  Future<void> _onInitData(CreateTournamentInitEvent event, Emitter<CreateTournamentState> emit) async {
    tournamentId = await usecases.tournamentRepository.getNextTournamentId();
    _players = [];
    _title = '';
    emit(CreateTournamentData(_title, _players, tournamentId, false));
  }

  void _onAddPlayer(AddPlayerEvent event, Emitter<CreateTournamentState> emit) {
    final playerName = event.playerName.trim();
    if (playerName.isNotEmpty) {
      final newPlayer = PlayerEntity(
          id: _players.isEmpty ? 1 : _players.last.id + 1, name: playerName);
      _players.add(newPlayer);

      emit(CreateTournamentData(_title, _players,tournamentId, false));
    } else {
      emit(CreateTournamentError("Enter player name"));
    }
  }

  void _onRemovePlayer(RemovePlayerEvent event, Emitter<CreateTournamentState> emit) {
    _players.removeWhere((player) => player.id == event.playerId);
    emit(CreateTournamentData(_title, _players,tournamentId, false));
  }

  void _onUpdateTitle(UpdateTitleEvent event, Emitter<CreateTournamentState> emit) {
    final title = event.title.trim();
    if (title.isNotEmpty) {
      _title = event.title;
      emit(CreateTournamentData(_title, _players,tournamentId, false));
    }
    else{
      emit(CreateTournamentData(_title, _players,tournamentId, true));
    }
  }

  Future<void> _onStartTournament(
      StartTournamentEvent event, Emitter<CreateTournamentState> emit) async {

    TournamentEntity tournament = TournamentEntity(winner: _players.first, name: _title, status: false, id: tournamentId, players: _players);

    TournamentEntity result = await usecases.tournamentRepository.addNewTournamentToDB(tournament);

    if(result.id==tournament.id){
      print('Starting tournament with title: $_title and players: $_players');
    }
    else{
      print('Error tournament with title: $_title and players: $_players');
    }

    // Here you would typically handle navigation to the next screen
    // and potentially pass the tournament data (title and players)
  }


}
