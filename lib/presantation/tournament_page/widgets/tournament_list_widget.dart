import 'package:flutter/cupertino.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';
import 'package:uno_notes/presantation/tournament_page/widgets/tournament_card_widget.dart';

import '../../create_tournament_page/scope_screen_arguments.dart';

class TournamentListView extends StatelessWidget {
  final List<TournamentEntity> allTournaments;
  final Function(ScopeScreenArguments) updateState;
  final Function(String, int) onLongPressed;

  const TournamentListView({super.key, required this.allTournaments, required this.updateState, required this.onLongPressed});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: allTournaments.length,
        itemBuilder: (BuildContext context, int index) {
          final tournament = allTournaments[index]; // Store a reference for readability.
          final winnerName = (tournament.listOfWinners.isNotEmpty)? tournament.listOfWinners.first.name : "...";
          return TournamentOverviewCard(
              tournamentName: tournament.title,
              playerCount: tournament.players.length,
              createdAt: tournament.getFormatedCreateAt(),
              winnerName: winnerName,
              onPressed: () {
                // 3. Navigate and then refresh.
                updateState(ScopeScreenArguments(tournamentId: tournament.id));
              },
            onLongPressed: (){ onLongPressed(tournament.title, tournament.id);},
            isFinished: tournament.isFinished,
          );
        }
    );
  }
}