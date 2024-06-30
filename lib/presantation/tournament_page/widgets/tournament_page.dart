import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_list_widget.dart';
import '../../../application/tournament_page/tournament_bloc.dart';
import '../../create_tournament_page/scope_screen_arguments.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {

  @override
  Widget build(BuildContext context) {
    final tournamentBloc = BlocProvider.of<TournamentBloc>(context);
    void sendNewEvent(TournamentEvent newEvent) {
      tournamentBloc.add(newEvent);
    }
    //Navigation
    void goToPageAndRefreshState(String route,  ScopeScreenArguments? args){
      Navigator.pushNamed(context, route, arguments: args).then((value) async => setState(() {
        sendNewEvent(RefreshTournamentsEvent());
      }));
    }

    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tournaments", // Pluralize for clarity since it's a list.
          style: themeData.textTheme.headlineLarge,
        ),
      ),
      body: BlocBuilder<TournamentBloc, TournamentState>(
        // No need to fetch tournaments again here, it was done above.
        bloc: tournamentBloc..add(InitTournamentsEvent()),
        builder: (context, tournamentState) {
          if (tournamentState is TournamentLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: themeData.colorScheme.secondary,
              ),
            );

          }
          if (tournamentState is TournamentEmptyState) {
            return const Center(child: Text("Create a new Tournament"));
          }
          else if (tournamentState is TournamentLoadedState) {
           return TournamentListView(allTournaments: tournamentState.tournaments, updateState: (scopeScreenArgs ) {
             goToPageAndRefreshState('/scopes_screen',scopeScreenArgs);
           },);
          } else {
            // Handle potential error states more explicitly.
            // Consider displaying an error message to the user.
            return const Center(child: Text(" error occurred."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "addTournament", // More specific hero tag.
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          // Use a more descriptive message for logging.
          print("Navigating to create tournament screen");
          goToPageAndRefreshState('/create_tournament_screen', null);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
