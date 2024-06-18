import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/domain/entities/score_entity.dart';
import 'package:uno_notes/presantation/scopes_page/scores_board_widget.dart';
import '../../application/scope_page/scope_bloc.dart';
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
    final tournamentId = args.tournamentId;
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    return BlocBuilder<ScopeBloc, ScopeState>(
      bloc: scopesBloc..add(LoadScopesEvent(arguments: args)),
      builder: (context, state) {
        if (state is OnLoadingDataState) {
          return Center(
            child: CircularProgressIndicator(
              color: themeData.colorScheme.background,
            ),
          );
        }
        if (state is LoadedDataState) {
          return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Scopes", // Pluralize for clarity since it's a list.
                    style: themeData.textTheme.headlineLarge,
                  )),
              body: Column(
                children: [
                  ScoreBoardWidget(scores: state.scores,),
                  const Spacer(),
                  AdPlaceholderWidget(),
                  FinishTournamentButton(),
                ],
              ));
        }
        else {
          // Handle potential error states more explicitly.
          // Consider displaying an error message to the user.
          return const Center(child: Text("An error occurred."));
        }
      },
    );
  }
}

class AdPlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 50,
      width: double.infinity,
      child: Center(
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Finish Tournament',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[300],
        ),
      ),
    );
  }
}

