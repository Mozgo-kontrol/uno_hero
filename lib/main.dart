import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uno_notes/presantation/create_tournament_page/widgets/tournament_create_page.dart';

import 'package:uno_notes/presantation/manage_scopes_page/manage_scopes_page.dart';

import 'package:uno_notes/presantation/scopes_page/scopes_page.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_page.dart';
import 'package:uno_notes/theme.dart';
import 'application/create_tournament_page/create_tournamet_bloc.dart';
import 'application/tournament_page/tournament_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart';
GetIt getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uno Hero',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: BlocProvider(
          create: (BuildContext context) => sl<TournamentBloc>(),
          child: const TournamentPage()
      ),
      routes: <String, WidgetBuilder>{
      "/root": (BuildContext context) => const TournamentPage(),
      "/create_tournament_screen": (BuildContext context) => BlocProvider(
          create: (BuildContext context) => sl<CreateTournamentBloc>(),
          child: const TournamentCreationPage()),
      "/scopes_screen": (BuildContext context) => ScopesPage(tuornamentId: ModalRoute.of(context)!.settings.arguments as int),
      "/manage_scopes_screen": (BuildContext context) => const ManageScopesScreen(),
    },
    );
  }
}
