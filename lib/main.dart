import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uno_notes/presantation/create_tournament_page/create_game_main_screen.dart';
import 'package:uno_notes/presantation/home_page/widgets/home_page.dart';

import 'package:uno_notes/presantation/scopes_page/widgets/scores_page.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_page.dart';
import 'package:uno_notes/theme.dart';
import 'application/create_tournament_page/create_tournamet_bloc.dart';
import 'application/scope_page/scope_bloc.dart';
import 'application/services/app_localizations.dart';
import 'application/services/theme_service.dart';
import 'application/tournament_page/tournament_bloc.dart';
import 'application/utils/utils.dart';
import 'domain/navigation/navigation.dart';
import 'injection.dart' as di;

GetIt getIt = GetIt.instance;

Future<void> main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeService(),
    child: const MyApp(),
  ));
  FlutterNativeSplash.remove();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          title: 'Uno Hero',
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          //themeMode: (themeService.isDarkModeOn) ? ThemeMode.dark : ThemeMode.light, //TODO implement theme switch
          // Define home route separately for clarity
          home: const Homepage(),
          routes: {
            NavigationRoute.mainScreen: (context) => const Homepage(),
            NavigationRoute.tournamentsScreen: (context) => BlocProvider(
              create: (context) => getIt<TournamentBloc>(),
              child: const TournamentPage(),
            ),
            NavigationRoute.createTournamentScreen: (context) => BlocProvider(
              create: (context) => getIt<CreateTournamentBloc>(),
              child: CreateGameScreen(),
           ),
            NavigationRoute.scopesScreen: (context) => BlocProvider(
              create: (context) => getIt<ScopeBloc>(),
              child: const ScopesPage(),
            ),
          },
          supportedLocales: Utils.supportedLocals,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // Simplify locale resolution
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.firstWhere(
                  (supportedLocale) => supportedLocale.languageCode == locale?.languageCode,
              orElse: () => supportedLocales.first,
            );
          },
        );
      },
    );
  }
}