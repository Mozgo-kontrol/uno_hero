import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_list_widget.dart';
import '../../../application/tournament_page/tournament_bloc.dart';
import '../../create_tournament_page/scope_screen_arguments.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState()=> _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  late final TournamentBloc _tournamentBloc;

  @override
  void initState() {
    super.initState();
    _tournamentBloc = BlocProvider.of<TournamentBloc>(context);
    _tournamentBloc.add(InitTournamentsEvent()); // Fetch tournaments on init.
  }

  // Navigation
  void _goToPageAndRefreshState(String route,  ScopeScreenArguments? args){
    Navigator.pushNamed(context, route, arguments: args).then((value) {
      if (mounted) { // Check if the widget is still mounted.
        setState(() {
          _tournamentBloc.add(RefreshTournamentsEvent());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData =Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tournaments",
          style: themeData.textTheme.displayLarge,
        ),
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.add_circle),
                iconSize: 45,
                onPressed: () {
                  debugPrint("Navigating to create tournament screen");
                  _goToPageAndRefreshState('/create_tournament_screen', null);
                },
              ),
            ),
        ],
      ),
      body: BlocBuilder<TournamentBloc, TournamentState>(
        bloc: _tournamentBloc,
        builder: (context, tournamentState) {
          if (tournamentState is TournamentLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: themeData.colorScheme.secondary,
              ),
            );
          } else if (tournamentState is TournamentEmptyState) {
            return const Center(child: Text("Create a new Tournament"));
          } else if (tournamentState is TournamentLoadedState) {
            return TournamentListView(
              allTournaments: tournamentState.tournaments,
              updateState: (scopeScreenArgs) {
                _goToPageAndRefreshState('/scopes_screen', scopeScreenArgs);
              },
            );
          } else {
            return const Center(child: Text("Unknown state encountered."));
          }
        },
      )
    );
  }
}