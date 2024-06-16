

import '../entities/tournament_entity.dart';

abstract class TournamentRepository{
  Future<List<TournamentEntity>> getAllTournamentsFromApi();
  Future<TournamentEntity>addNewTournamentToDB(TournamentEntity tournament);
  Future<TournamentEntity>findTournamentById(int id);
  Future<int>getNextTournamentId();
}