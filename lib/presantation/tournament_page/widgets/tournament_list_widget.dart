import 'package:flutter/cupertino.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_card_widget.dart';

import '../../create_tournament_page/scope_screen_arguments.dart';
class TournamentListWidget extends StatelessWidget {

  final List<TournamentEntity> tournaments;

  const TournamentListWidget({super.key, required this.tournaments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tournaments.length,
        itemBuilder: (BuildContext context, int index) {
          return TournamentCardWidget(
            tournamentName: tournaments[index].name,
            playerCount: tournaments[index].players.length,
            status: tournaments[index].status,
            winnerName: tournaments[index].winner.name, onPressed: ()=>
          {
          Navigator.pushNamed(context, '/scopes_screen', arguments: ScopeScreenArguments(tournamentId: tournaments[index].id))
          }
          );
        }
    );
  }
}
