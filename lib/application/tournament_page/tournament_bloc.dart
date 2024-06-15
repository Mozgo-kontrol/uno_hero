import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {

  final ManageTournamentsUsecases usecases;


  TournamentBloc({required this.usecases}) : super(TournamentInitial()) {
    on<InitTournamentsEvent>((event, emit) async {
      emit(TournamentLoadingState());
      //do something
      //Either<Failure, AdviceEntity> adviceOrFailure =
      //await usecases.getAdviceUsecase();

      final tournaments =  await usecases.getAllTournamentsUsecase();

      await Future.delayed(const Duration(seconds: 1));

      emit(TournamentLoadedState(tournaments));
      //get advice
      //String adviceFromDataSource = advice.advice;

    });
  }

  FutureOr<void> _onLoadTournaments(
      LoadTournamentsEvent event, Emitter<TournamentState> emit) async {

    emit(TournamentLoadingState());

    // Simulate fetching tournaments (replace with actual data fetching logic)
    final tournaments = initTournament();
    await Future.delayed(const Duration(seconds: 1));

    emit(TournamentLoadedState(tournaments));
  }

  List<TournamentEntity> initTournament() {

    List<Player> players  = [
      Player(id: 1, name: "Igor"),
      Player(id: 2, name: "Hanna"),
    ];
    return [TournamentEntity(
      name: "Tournament 1",
      winner: players[0],
      id: 1,
      status: false,
      players: players,
    ),TournamentEntity(
      name: "Tournament 2",
      winner: players[0],
      id: 2,
      status: true,
      players: players,
    ),
      TournamentEntity(
        name: "Tournament 3",
        winner: players[0],
        id: 3,
        status: true,
        players: players,
      )];
  }
}

