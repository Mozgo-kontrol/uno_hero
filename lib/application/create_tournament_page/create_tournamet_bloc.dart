import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';
import 'Error.dart';

part 'create_tournament_event.dart';

part 'create_tournament_state.dart';

class CreateTournamentBloc
    extends Bloc<CreateTournamentEvent, CreateTournamentState> {
  final ManageTournamentsUsecases usecases;
  late TournamentEntity tournament;
  late List<PlayerEntity> _players;
  late String _title;
  late int _tournamentId;
  late Set<CustomInputError> errors; // Initialize an empty set

  CreateTournamentBloc({required this.usecases})
      : super(CreateTournamentInitialState()) {
    on<CreateTournamentInitEvent>(_onInitData);
    on<AddPlayerEvent>(_onAddPlayer);
    on<RemovePlayerEvent>(_onRemovePlayer);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<StartTournamentEvent>(_onStartTournament);
  }


  Future<void> _onInitData(CreateTournamentInitEvent event,
      Emitter<CreateTournamentState> emit) async {
      print("onInitData");
      _tournamentId = await usecases.tournamentRepository.getNextTournamentId();
      _players = [];
      _title = '';
      errors = {};
      emit(CreateTournamentData(_title, _players, _tournamentId, checkIfCanStart(), errors));
    //}
  }

  void _onAddPlayer(AddPlayerEvent event, Emitter<CreateTournamentState> emit) {
    final playerName = event.playerName.trim();
    if (playerName.isNotEmpty) {
      final newPlayer = PlayerEntity(
          id: _players.isEmpty ? 1 : _players.last.id + 1, name: playerName);
      _players.add(newPlayer);
      print("onAddPlayer");
      emit(CreateTournamentData(_title, _players, _tournamentId, checkIfCanStart(), errors));
    } else {
      emit(CreateTournamentError("Enter player name"));
    }
  }

  void _onRemovePlayer(
      RemovePlayerEvent event, Emitter<CreateTournamentState> emit) {
    _players.removeWhere((player) => player.id == event.playerId);
    print("onRemovePlayer");
    emit(CreateTournamentData(_title, _players, _tournamentId, checkIfCanStart(), errors));
  }
  void _onUpdateTitle(
      UpdateTitleEvent event, Emitter<CreateTournamentState> emit) {
    String changedValue = event.title.trim();
    _title = changedValue;
    if (changedValue.isNotEmpty) {
      errors = {};
    } else {
      error(CustomInputError.titleEmpty);
    }
    emit(CreateTournamentData(_title, _players, _tournamentId, checkIfCanStart(), errors));
  }

  Future<void> _onStartTournament(
      StartTournamentEvent event, Emitter<CreateTournamentState> emit) async {
    TournamentEntity tournament = TournamentEntity(
        id: _tournamentId,
        title: _title,
        players: _players);

    TournamentEntity result =
        await usecases.tournamentRepository.addNewTournamentToDB(tournament);

    if (result.id == tournament.id) {
      print('Starting tournament with title: $_title and players: $_players');
    } else {
      print('Error tournament with title: $_title and players: $_players');
    }
  }

  bool checkIfCanStart(){
    return _title.isNotEmpty&&_players.length>1;
  }

  void error(CustomInputError error){
    errors.add(error);
  }

}
