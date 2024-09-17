part of 'create_tournamet_bloc.dart';

@immutable
sealed class CreateTournamentState {}

class CreateTournamentInitialState extends CreateTournamentState {}

class CreateTournamentLoading extends CreateTournamentState {}

class CreateTournamentData extends CreateTournamentState {
  final int tournamentId;
  final String title;
  int maxScore;
  final List<PlayerEntity> players;
  final bool isReadyToStart;
  final Set<CustomInputError> errors;
  CreateTournamentData(this.title, this.players, this.tournamentId, this.isReadyToStart, this.maxScore, [this.errors = const {}]);
}

class CreateTournamentError extends CreateTournamentState {
  final String message;
  CreateTournamentError(this.message);
}
