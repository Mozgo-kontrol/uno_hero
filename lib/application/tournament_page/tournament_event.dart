part of 'tournament_bloc.dart';

@immutable
sealed class TournamentEvent {}

class InitTournamentsEvent extends TournamentEvent {}
class LoadTournamentsEvent extends TournamentEvent {}
