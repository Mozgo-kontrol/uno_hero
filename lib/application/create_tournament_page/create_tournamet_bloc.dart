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

  CreateTournamentBloc({required this.usecases})
      : super(CreateTournamentInitialState()) {
    on<CreateTournamentInitEvent>(_onInitData);
    on<AddPlayerEvent>(_onAddPlayer);
    on<RemovePlayerEvent>(_onRemovePlayer);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<StartTournamentEvent>(_onStartTournament);
  }

  late TournamentEntity tournament;
  List<PlayerEntity> _players = [];
  String _title = '';
  late int _tournamentId = 0; //default value
  Set<CustomInputError> errors = {}; // Initialize an empty set

  Future<void> _onInitData(CreateTournamentInitEvent event,
      Emitter<CreateTournamentState> emit) async {
    print("onInitData");
    if(_tournamentId!=0){
      emit(CreateTournamentData(_title, _players, _tournamentId, false));
    }
    else{
      _tournamentId = await usecases.tournamentRepository.getNextTournamentId();
      _players = [];
      emit(CreateTournamentData(_title, _players, _tournamentId, false));
    }
  }

  void _onAddPlayer(AddPlayerEvent event, Emitter<CreateTournamentState> emit) {
    final playerName = event.playerName.trim();
    if (playerName.isNotEmpty) {
      final newPlayer = PlayerEntity(
          id: _players.isEmpty ? 1 : _players.last.id + 1, name: playerName);
      _players.add(newPlayer);
      print("onAddPlayer");
      emit(CreateTournamentData(_title, _players, _tournamentId, false,));
    } else {
      emit(CreateTournamentError("Enter player name"));
    }
  }

  void _onRemovePlayer(
      RemovePlayerEvent event, Emitter<CreateTournamentState> emit) {
    _players.removeWhere((player) => player.id == event.playerId);
    print("onRemovePlayer");
    emit(CreateTournamentData(_title, _players, _tournamentId, false, ));
  }
   //TODO title update very frequently
  void _onUpdateTitle(
      UpdateTitleEvent event, Emitter<CreateTournamentState> emit) {
    print("onUpdateTitle");
    final title = event.title.trim();
    if (title.isNotEmpty) {
      _title = event.title;
      emit(CreateTournamentData(_title, _players, _tournamentId, false));
      errors ={};
    } else {
      error(CustomInputError.titleEmpty);
      emit(CreateTournamentData(_title, _players, _tournamentId, true, errors));
    }
  }

  void error(CustomInputError error){
    errors.add(error);
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
}
