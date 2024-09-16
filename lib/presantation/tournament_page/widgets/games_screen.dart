import 'package:flutter/material.dart';
import 'package:uno_notes/application/utils/utils.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../create_tournament_page/scope_screen_arguments.dart';

class GamesScreen extends StatelessWidget {
  final Function(ScopeScreenArguments) updateState;
  final Function(String, int) onLongPressed;
  final List<TournamentEntity>
      tournaments;
  const GamesScreen(
      {super.key,
      required this.tournaments,
      required this.updateState,
      required this.onLongPressed});

  Map<String, List<TournamentEntity>> _groupTournamentsByDate() {
    // Use a Map constructor for more concise initialization
    Map<String, List<TournamentEntity>> groupedTournaments = {};
    for (var tournament in tournaments) {
      print(tournament.toString());
      String formattedDate = Utils.dateFormatter(tournament.createdAt);
      (groupedTournaments[formattedDate] ??= [])
          .add(tournament); // Use null-aware operator for brevity
    }
    return groupedTournaments;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<TournamentEntity>> tournamentsByDate =
        _groupTournamentsByDate();
    return ListView(
      children: tournamentsByDate.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Extract date header into a separate widget for reusability
              DateHeader(date: entry.key),
              ...entry.value.map((tournament) {
                return TournamentCard(
                  tournament: tournament,
                  onLongPressed: () {
                    onLongPressed(tournament.title, tournament.id);
                  },
                  onPressed: () {
                    updateState(
                        ScopeScreenArguments(tournamentId: tournament.id));
                  },
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Widget for the date header
class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

// Widget for individual tournament cards
class TournamentCard extends StatelessWidget {
  final TournamentEntity tournament;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  const TournamentCard(
      {super.key,
      required this.tournament,
      required this.onLongPressed,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Color generalColor = Utils.getRandomColors();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal:  8),
      child: ListTile(
        onTap:  onPressed,
        onLongPress: onLongPressed,
        title: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            tournament.title,
            style: TextStyle(
              color: generalColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'players: ${tournament.players.length}    rounds: 1',
            style: TextStyle(
              color: generalColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //TODO rounds,
        contentPadding: const EdgeInsets.only(left:12),
        trailing: IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(
            Icons.skip_next_rounded,
            color: generalColor,
            weight: 50,
            size: 45,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
