

import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/repositories/TournamentRepository.dart';
import '../datasources/remote_database.dart';

class RepositoryImpl implements TournamentRepository{

  final RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() async {
    final listOfTournaments = await remoteDataSource.getAllTournamentsFromApi();
    return listOfTournaments;
  }

  @override
  Future<TournamentEntity> addNewTournamentToDB(TournamentEntity tournament) async {
    final newTournament = await remoteDataSource.addTournamentToDB(tournament);
    return newTournament;
  }

  @override
  Future<TournamentEntity> findTournamentById(int id) async {
    final getTournament = await remoteDataSource.findTournamentById(id);
    return Future.value(getTournament);
  }

  @override
  Future<int> getNextTournamentId() async {
    final lastTournament = await remoteDataSource.getNextTournamentId();
    return Future.value(lastTournament);
  }

  @override
  Future<void> updateTournament(TournamentEntity tournamentEntity) async {
    remoteDataSource.updateTournament(tournamentEntity);
  }
}
