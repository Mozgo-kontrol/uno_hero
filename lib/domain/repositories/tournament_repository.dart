

import '../entities/tournament_entity.dart';

abstract class TournamentRepository{
  Future<List<TournamentEntity>> getAllTournamentsFromApi();
  Future<TournamentEntity>addNewTournamentToDB(TournamentEntity tournament);
  Future<TournamentEntity>findTournamentById(int id);
  Future<int>getNextTournamentId();
  Future<void> updateTournament(TournamentEntity tournamentEntity);
  Future<void> finishTournament(int id);
  Future<void> removeTournamentById(int id);
  Future<List<TournamentEntity>> getAllActiveTournaments();
  Future<List<TournamentEntity>> getAllFinishedTournaments();
}