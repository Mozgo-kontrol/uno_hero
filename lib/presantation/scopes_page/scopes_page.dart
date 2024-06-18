import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/scopes_page/scores_board_widget.dart';
import '../../application/scope_page/scope_bloc.dart';
import '../create_tournament_page/scope_screen_arguments.dart';

class ScopesPage extends StatelessWidget {
  const ScopesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScopeScreenArguments;
    final scopesBloc = BlocProvider.of<ScopeBloc>(context);
    final size = MediaQuery
        .of(context)
        .size;
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
            ],),
        body: BlocBuilder<ScopeBloc, ScopeState>(
            bloc: scopesBloc..add(LoadScopesEvent(arguments: args)),
            builder: (context, state) {
              if (state is LoadedDataState) {
                return SafeArea(
                  child: Column(
                    children: [
                      ScoreBoardWidget(scores: state.scores,),
                      AdPlaceholderWidget(),
                      FinishTournamentButton(size: size,),
                    ],
                  ),
                );
              }
              else if (state is OnLoadingDataState) {
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
  FinishTournamentButton({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: size.width*0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {   },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[300],
          ),
          child: const Text(
            'Manage Scores',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}

