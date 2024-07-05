part of 'tournament_bloc.dart';

@immutable
sealed class TournamentEvent {}

class InitTournamentsEvent extends TournamentEvent {}
class LoadTournamentsEvent extends TournamentEvent {}
class RefreshTournamentsEvent extends TournamentEvent {}
class RemoveTournamentEvent extends TournamentEvent{
  final int tournamentId;
  RemoveTournamentEvent({required this.tournamentId});
}