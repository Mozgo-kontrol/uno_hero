part of 'tournament_bloc.dart';

@immutable
sealed class TournamentState {}

class TournamentInitial extends TournamentState {}

class TournamentLoadingState extends TournamentState {}

class TournamentLoadedState extends TournamentState {
  final List<TournamentEntity> tournaments;
  TournamentLoadedState(this.tournaments);
}