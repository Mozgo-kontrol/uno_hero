import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/usecases/manage_players_use_cases.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';
import 'Error.dart';

part 'create_tournament_event.dart';

part 'create_tournament_state.dart';

class CreateTournamentBloc
    extends Bloc<CreateTournamentEvent, CreateTournamentState> {
  final ManageTournamentsUsecases tournamentsUseCases;
  final ManagePlayersUseCases playersUseCases;
  late TournamentEntity tournament;
  late List<PlayerEntity> _players;
  late String _title;
  late int _maxScore;
  late int _tournamentId;
  late Set<CustomInputError> errors; // Initialize an empty set

  CreateTournamentBloc(
      {required this.playersUseCases, required this.tournamentsUseCases})
      : super(CreateTournamentInitialState()) {
    on<CreateTournamentInitEvent>(_onInitData);
    on<AddPlayerEvent>(_onAddPlayer);
    on<RemovePlayerEvent>(_onRemovePlayer);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<AddMaxScoreEvent>(_addMaxScore);
    on<StartTournamentEvent>(_onStartTournament);
    on<MinusMaxScoreEvent>(_minusMaxScore);
  }

  Future<void> _onInitData(CreateTournamentInitEvent event,
      Emitter<CreateTournamentState> emit) async {
    print("onInitData");
    _tournamentId =
        await tournamentsUseCases.tournamentRepository.getNextTournamentId();
    _players = await playersUseCases.getAllPlayers();
    _title = '';
    errors = {};
    _maxScore = 500;
    emit(CreateTournamentData(
        _title, _players, _tournamentId, checkIfCanStart(), _maxScore,  errors));
  }

  Future<void> _addMaxScore(
      AddMaxScoreEvent event, Emitter<CreateTournamentState> emit) async {
      print("addMaxScore");
      _maxScore = _maxScore + 10;
      emit(CreateTournamentData(
          _title, _players, _tournamentId, checkIfCanStart(), _maxScore, errors));
  }

Future<void> _minusMaxScore(
    MinusMaxScoreEvent event, Emitter<CreateTournamentState> emit) async {
  print("minusMaxScore");
  if(_maxScore - 10 > 0){
    _maxScore = _maxScore - 10;
  }
  else{
    _maxScore = 0;
  }
  emit(CreateTournamentData(
      _title, _players, _tournamentId, checkIfCanStart(), _maxScore, errors));
}


  Future<void> _onAddPlayer(
      AddPlayerEvent event, Emitter<CreateTournamentState> emit) async {
    final playerName = event.playerName.trim();
    if (playerName.isNotEmpty) {
      final newPlayer = PlayerEntity(
          id: _players.isEmpty ? 1 : _players.last.id + 1,
          name: playerName,
          iconId: event.playerIconId);
      _players.add(newPlayer);

      await playersUseCases.addNewPlayer(newPlayer);
      print("onAddPlayer");
      emit(CreateTournamentData(
          _title, _players, _tournamentId, checkIfCanStart(), _maxScore, errors));
    } else {
      emit(CreateTournamentError("Enter player name"));
    }
  }

  Future<void> _onRemovePlayer(
      RemovePlayerEvent event, Emitter<CreateTournamentState> emit) async {
    _players.removeWhere((player) => player.id == event.playerId);
    await playersUseCases.removePlayerById(event.playerId);
    print("onRemovePlayer");
    emit(CreateTournamentData(
        _title, _players, _tournamentId, checkIfCanStart(), _maxScore, errors));
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
    emit(CreateTournamentData(
        _title, _players, _tournamentId, checkIfCanStart(), _maxScore, errors));
  }

  Future<void> _onStartTournament(
      StartTournamentEvent event, Emitter<CreateTournamentState> emit) async {
    TournamentEntity tournament = TournamentEntity(
        id: _tournamentId,
        title: _title,
        players: _players,
        createdAt: DateTime.now());

    TournamentEntity result = await tournamentsUseCases.tournamentRepository
        .addNewTournamentToDB(tournament);

    if (result.id == tournament.id) {
      print('Starting tournament with title: $_title and players: $_players');
    } else {
      print('Error tournament with title: $_title and players: $_players');
    }
  }

  bool checkIfCanStart() {
    return _title.isNotEmpty && _players.length > 1;
  }

  void error(CustomInputError error) {
    errors.add(error);
  }
}
