part of 'create_tournamet_bloc.dart';

@immutable
sealed class CreateTournamentState {}

class CreateTournamentInitialState extends CreateTournamentState {}

class CreateTournamentLoading extends CreateTournamentState {}

class CreateTournamentData extends CreateTournamentState {
  final int tournamentId;
  final String title;
  final List<Player> players;
  CreateTournamentData(this.title, this.players, this.tournamentId);
}

class CreateTournamentError extends CreateTournamentState {
  final String message;
  CreateTournamentError(this.message);
}
