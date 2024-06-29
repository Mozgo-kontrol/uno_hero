import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/scopes_page/widgets/scores_board_widget.dart';
import '../../../application/scope_page/scope_bloc.dart';
import '../../../domain/entities/score_board_item.dart';
import '../../create_tournament_page/scope_screen_arguments.dart';
import '../../manage_scopes_page/manage_scores_page_dialog.dart';

class ScopesPage extends StatefulWidget {
  const ScopesPage({super.key});

  @override
  State<ScopesPage> createState() => _ScopesPageState();
}

class _ScopesPageState extends State<ScopesPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as ScopeScreenArguments;

    // 2. Extract the BlocProvider to a separate variable for better readability.
    final scopesBloc = BlocProvider.of<ScopeBloc>(context);
    void sendNewEvent(ScopeEvent newEvent) {
      scopesBloc.add(newEvent);
    }

    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Scores", // Pluralize for clarity since it's a list.
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
        ],
      ),
      body: BlocBuilder<ScopeBloc, ScopeState>(
          bloc: scopesBloc..add(LoadScopesEvent(arguments: args)),
          builder: (context, state) {
            if (state is LoadedDataState) {
              return SafeArea(
                child: Column(
                  children: [
                    ScoreBoardWidget(
                      scores: state.listOfScoresBoardItems,
                    ),
                    AdPlaceholderWidget(),
                    FinishTournamentButton(
                        size: size,
                        args: args,
                        state: state,
                        sendNewEvent: sendNewEvent),
                  ],
                ),
              );
            } else if (state is OnLoadingDataState) {
              return Center(
                child: CircularProgressIndicator(
                  color: themeData.colorScheme.background,
                ),
              );
            } else {
              // Handle potential error states more explicitly.
              // Consider displaying an error message to the user.
              return const Center(child: Text("An error occurred."));
            }
          }),
    );
  }
}

class AdPlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 80,
      width: double.infinity,
      child: const Center(
        child: Text(
          'ADS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class FinishTournamentButton extends StatelessWidget {
  final Size size;
  final Function(UpdatePlayerScoreEvent) sendNewEvent;
  final ScopeScreenArguments args;
  final LoadedDataState state;

  const FinishTournamentButton(
      {super.key,
      required this.size,
      required this.args,
      required this.state,
      required this.sendNewEvent});


  @override
  Widget build(BuildContext context) {

    void shoBottomSheet(List<ScoreBoardItem> listOfScoresBoardItems){
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => BottomScreenDialogScreen(
          scoresBoardItems: listOfScoresBoardItems,
          // Pass the non-null data
          onUpdateScore: sendNewEvent,
        ),
      );
    }

    return SizedBox(
      height: 80,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            print("press manage scores button");
            shoBottomSheet(state.listOfScoresBoardItems);
            // Navigator.pushNamed(context, '/manage_scopes_screen',
            //    arguments: ManageScreenArguments(tournamentId: args.tournamentId));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[300],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(49.0),
                  topRight: Radius.circular(49.0)),
            ),
          ),
          child: const Text(
            'MANAGE SCORES',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
