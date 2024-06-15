import 'package:get_it/get_it.dart';
import 'package:uno_notes/application/home_page/home_bloc.dart';
import 'package:uno_notes/application/tournament_page/tournament_bloc.dart';

import 'domain/repositories/TournamentRepository.dart';
import 'domain/usecases/manage_tournaments_usecases.dart';
import 'infrastructure/datasources/remote_database.dart';
import 'infrastructure/repository/tournament_repository_impl.dart';

final sl = GetIt.I; // service locator

Future<void>init() async {
  ///Dependency injection
  ///
  /// block
 // sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => TournamentBloc(usecases: sl()));
  sl.registerLazySingleton(() => ManageTournamentsUsecases(tournamentRepository: sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<TournamentRepository>(() => RepositoryImpl(remoteDataSource: sl()));

}