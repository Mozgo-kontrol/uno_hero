import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uno_notes/application/utils/utils.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/usecases/manage_tournaments_usecases.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {

  final ManageTournamentsUsecases usecases;


  TournamentBloc({required this.usecases}) : super(TournamentInitial()) {
    on<InitTournamentsEvent>((event, emit) async {
      emit(TournamentLoadingState());
      print("TournamentInitial");
      List<TournamentEntity> tournaments = await usecases.getAllTournamentsUsecase();
      await Future.delayed(const Duration(seconds: 1));
      if(tournaments.isEmpty){
        emit(TournamentEmptyState());
      }
      else {
        Utils.sortTournamentsByScore(tournaments);
        emit(TournamentLoadedState(tournaments));
      }
    });
    on<RefreshTournamentsEvent>(_onRefreshTournaments);

  }
  Future<void> _onRefreshTournaments(RefreshTournamentsEvent event, Emitter<TournamentState> emit) async {
    // Fetch the updated list of tournaments
    emit(TournamentLoadingState());
    //await Future.delayed(const Duration(seconds: 1));
    final tournaments = await usecases.getAllTournamentsUsecase();
    // Emit a new state with the updated list
    emit(TournamentLoadedState(tournaments)); // Assuming you have a state like this
  }
}

