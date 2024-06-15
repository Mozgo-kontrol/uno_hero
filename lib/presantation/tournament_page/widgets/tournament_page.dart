import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/tournament_page/tournament_bloc.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/entities/tournament_entity.dart';
import 'Tournament_list_widget.dart';


class TournamentPage extends StatelessWidget {

  const TournamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tournament",
          style: themeData.textTheme.headlineLarge,
        ),
      ),
      body: BlocBuilder<TournamentBloc, TournamentState>(
        bloc: BlocProvider.of<TournamentBloc>(context)..add(InitTournamentsEvent()),
        builder: (context, tournamentState) {
          if(tournamentState is TournamentLoadingState){
           return Center(
             child: CircularProgressIndicator(
               color: themeData.colorScheme.secondary,
             ),
           );
          }
          else if(tournamentState is TournamentLoadedState){
            return TournamentListWidget(tournaments: tournamentState.tournaments,);
          }
          else {
            return const Placeholder();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () =>
        {
          print("floating action button"),
          Navigator.of(context).pushNamed('/create_tournament_screen')
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

}