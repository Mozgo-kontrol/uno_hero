import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:uno_notes/presantation/manage_scopes_page/widget/edit_players_score_stepper_widget.dart';

import '../../application/common_widgets/ads_place_holder_widget.dart';
import '../../application/scope_page/scope_bloc.dart';

import '../../domain/entities/score_board_item.dart';

class BottomScreenDialogScreen extends StatefulWidget {
  final List<ScoreBoardItem> scoresBoardItems;
  final Function(UpdatePlayerScoreEvent) onUpdateScore;

  const BottomScreenDialogScreen(
      {super.key, required this.scoresBoardItems, required this.onUpdateScore});

  @override
  State<BottomScreenDialogScreen> createState() =>
      _BottomScreenDialogScreenState();
}

class _BottomScreenDialogScreenState extends State<BottomScreenDialogScreen> {

  late Map<int, int> mapPlayerScores;
  @override
  void initState() {
  super.initState();
  mapPlayerScores = HashMap();
  for (var item in widget.scoresBoardItems) {
    mapPlayerScores.putIfAbsent(item.playerId, () => 0);
  }
  }

  void updateOnePlayerScoreEvent(UpdateOnePlayerScoreEvent newEvent) {
    if (mapPlayerScores.containsKey(newEvent.playerId)) {
      mapPlayerScores.update(
          newEvent.playerId, (value) => newEvent.updatedScore);
    } else {
      mapPlayerScores.putIfAbsent(
          newEvent.playerId, () => newEvent.updatedScore);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;

    if (widget.scoresBoardItems.isEmpty) {
      return Center(child: Text("No data available", style: themeData.textTheme.bodyMedium,));
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(16, size.height * 0.08, 16, 32),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Manage Scores',
                style: themeData.textTheme.displayLarge,
              ),
            ),
            Expanded(
              child: EditPlayersScoreStepper(
                  listOfScoresBoardItems: widget.scoresBoardItems,
                  onUpdateScore: updateOnePlayerScoreEvent),
            ),
            SizedBox(
              height: 70,
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  print("press manage scores back button");
                  widget.onUpdateScore(UpdatePlayerScoreEvent(
                      mapOfPlayersScores: mapPlayerScores));
                  Navigator.pop(context);
                  //    arguments: ManageScreenArguments(tournamentId: args.tournamentId));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'SAVE AND BACK',
                     style: themeData.textTheme.labelMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
