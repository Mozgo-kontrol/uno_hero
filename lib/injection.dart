import 'package:get_it/get_it.dart';
import 'package:uno_notes/application/home_page/home_bloc.dart';

final sl = GetIt.I; // service locator

Future<void>init() async {
  ///Dependency injection
  ///
  /// block
  sl.registerFactory(() => HomeBloc());

}