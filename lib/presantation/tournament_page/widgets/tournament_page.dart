import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_list_widget.dart';
import '../../../application/common_widgets/pop_up_dialog.dart';
import '../../../application/services/app_localizations.dart';
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

  void _showTopPopup(BuildContext context, int id, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
            alignment: Alignment.topCenter, // Position the popup at the top
            child: TopPopupDialog(
              errorType: 'Warning',
              message:
              'Do you want remove tournament $title?',
              onAgree: () {
                sendEvent(RemoveTournamentEvent(tournamentId: id));
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ));
      },
    );
  }

  void sendEvent(TournamentEvent event){
    _tournamentBloc.add(event);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData =Theme.of(context);
    final localizations = AppLocalizations.fromContext(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          localizations?.get('game') ?? "Game",
          style: themeData.textTheme.displayLarge,
        ),
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0, bottom: 8),
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
            return Center(child: Text( localizations?.get('create_game') ?? "Create a new game"));
          } else if (tournamentState is TournamentLoadedState) {
            return TournamentListView(
              allTournaments: tournamentState.tournaments,
              updateState: (scopeScreenArgs) {
                _goToPageAndRefreshState('/scopes_screen', scopeScreenArgs);
              },
              onLongPressed:(id, title) { print("long click") ; _showTopPopup(context, title, id);
              }
            );
          } else {
            return Center(child: Text(localizations?.get('unknown_error') ?? "Unknown error!"));
          }
        },
      )
    );
  }
}