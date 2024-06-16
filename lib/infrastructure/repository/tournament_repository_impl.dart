

import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/repositories/TournamentRepository.dart';
import '../datasources/remote_database.dart';

class RepositoryImpl implements TournamentRepository{

  final RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() async {
    // TODO: implement getAllTournamentsFromApi
    final listOfTournaments = await remoteDataSource.getAllTournamentsFromApi();
    return listOfTournaments;
  }

  @override
  Future<TournamentEntity> addNewTournamentToDB(TournamentEntity tournament) async {
    final newTournament = await remoteDataSource.addTournamentToDB(tournament);
    return newTournament;
  }

  @override
  Future<TournamentEntity> findTournamentById(int id) {
    // TODO: implement findTournamentById
    return Future.value(null);
  }

  @override
  Future<TournamentEntity> getLastAddedTournament() async {
    // TODO: implement getLastAddedTournament
    final lastTournament = await remoteDataSource.getLastAddedTournament();
   return Future.value(lastTournament);
  }
}
