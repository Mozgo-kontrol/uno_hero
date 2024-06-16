import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uno_notes/application/create_tournament_page/create_tournamet_bloc.dart';
import 'package:uno_notes/application/tournament_page/tournament_bloc.dart';
import 'application/scope_page/scope_bloc.dart';
import 'domain/entities/player_entity.dart';
import 'domain/entities/tournament_entity.dart';
import 'domain/repositories/TournamentRepository.dart';
import 'domain/usecases/manage_tournaments_usecases.dart';
import 'infrastructure/datasources/remote_database.dart';
import 'infrastructure/repository/tournament_repository_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';
final sl = GetIt.I; // service locator

Future<void>init() async {
  ///Dependency injection
  ///
  /// block
 // sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => TournamentBloc(usecases: sl()));
  sl.registerLazySingleton(() => ManageTournamentsUsecases(tournamentRepository: sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<TournamentRepository>(() => RepositoryImpl(remoteDataSource: sl()));

  sl.registerFactory(() => ScopeBloc());

  sl.registerFactory(() => CreateTournamentBloc(usecases: sl()));

  /// Initialize Hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  /// Register Adapters (if you have custom objects)
  Hive.registerAdapter(TournamentEntityAdapter());
  Hive.registerAdapter(PlayerEntityAdapter());
  /// Open Boxes and Register them with GetIt
  final tournamentBox = await Hive.openBox<TournamentEntity>('Tournaments');
  sl.registerSingleton<Box<TournamentEntity>>(tournamentBox);
}

