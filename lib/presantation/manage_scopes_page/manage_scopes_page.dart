import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/manage_scopes_page/widget/edit_players_score_stepper_widget.dart';


import '../../application/manage_players_core_page/manage_scores_bloc.dart';
import '../scopes_page/manage_scores_screen_arguments.dart';
import '../scopes_page/widgets/scores_page.dart';


class ManageScopesScreen extends StatelessWidget {
  const ManageScopesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final manageScores = BlocProvider.of<ManageScoresBloc>(context);
    void sendNewEvent(ManageScoresEvent newEvent) {
      manageScores.add(newEvent);
    }

    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments as ManageScreenArguments;

    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Manage Scores", // Pluralize for clarity since it's a list.
            style: themeData.textTheme.headlineLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.flag_circle_outlined),
                iconSize: 40,
                onPressed: () {
                  print('Settings icon pressed');
                },
              ),
            ),
          ],),
        body: BlocBuilder<ManageScoresBloc, ManageScoresState>(
            bloc: manageScores..add(InitManageScoresEvent(tournamentId: args.tournamentId)),
            builder: (context, state) {

              if (state is ShowScreenManageScoresState) {
                return SafeArea(
                  child: Column(
                    children: [
                      Expanded(child: SingleChildScrollView(
                          physics: state.mapOfScores.length-1 >= 6
                              ? const ClampingScrollPhysics() // Enable scrolling if needed
                              : const NeverScrollableScrollPhysics(), //
                          child: EditPlayersScoreStepper(playerScores: state.mapOfScores, onUpdateScore: sendNewEvent,))),
                      //ManageScoreBoardWidget(mapOfScores: state.mapOfScores, sendNewEvent: sendNewEvent,),
                      AdPlaceholderWidget(),
                      //FinishTournamentButton(size: size, args: args, sendNewEvent: sendNewEvent),
                    ],
                  ),
                );
              }
              else if (state is OnLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: themeData.colorScheme.background,
                  ),
                );
              }
              else {
                // Handle potential error states more explicitly.
                // Consider displaying an error message to the user.
                return const Center(child: Text("An error occurred."));
              }
            })
    );
  }
}
