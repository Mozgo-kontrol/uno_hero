

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
}
