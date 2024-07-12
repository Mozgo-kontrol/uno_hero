

import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/repositories/TournamentRepository.dart';
import '../datasources/local_database.dart';

class RepositoryImpl implements TournamentRepository{

  final LocalDataSource localDataSource;

  RepositoryImpl({required this.localDataSource});

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() async {
    final listOfTournaments = await localDataSource.getAllTournamentsFromApi();
    return listOfTournaments;
  }

  @override
  Future<TournamentEntity> addNewTournamentToDB(TournamentEntity tournament) async {
    final newTournament = await localDataSource.addTournamentToDB(tournament);
    return newTournament;
  }

  @override
  Future<TournamentEntity> findTournamentById(int id) async {
    final getTournament = await localDataSource.findTournamentById(id);
    return Future.value(getTournament);
  }

  @override
  Future<int> getNextTournamentId() async {
    final lastTournament = await localDataSource.getNextTournamentId();
    return Future.value(lastTournament);
  }

  @override
  Future<void> updateTournament(TournamentEntity tournamentEntity) async {
    localDataSource.updateTournament(tournamentEntity);
  }

  @override
  Future<void> finishTournament(int id) async {
    localDataSource.finishTournament(id);
  }

  @override
  Future<void> removeTournamentById(int id) async {
    localDataSource.removeTournamentById(id);
  }
}
