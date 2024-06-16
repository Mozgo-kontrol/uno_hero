import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/tournament_page/tournament_bloc.dart';
import '../create_tournament_page/scope_screen_arguments.dart';

class ScopesPage extends StatelessWidget {
  const ScopesPage({super.key});



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ScopeScreenArguments;
    final tournamentId = args.tournamentId;
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    return Scaffold(
          appBar: AppBar(
            title: Text("Details Page",
                style: themeData.textTheme.headlineLarge),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: themeData.appBarTheme.foregroundColor),
                onPressed: () => Navigator.pop(context, (){
                  context.read<TournamentBloc>().add(RefreshTournamentsEvent());
                })
            ),
          ),
          body: Center(
            child: Text('Received integer: $tournamentId'),
          ),
    );
  }
}
