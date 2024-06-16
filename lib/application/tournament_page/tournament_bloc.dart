import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

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

      final tournaments = await usecases.getAllTournamentsUsecase();

      await Future.delayed(const Duration(seconds: 1));

      emit(TournamentLoadedState(tournaments));
      //get advice
      //String adviceFromDataSource = advice.advice;

    });
  }
}

