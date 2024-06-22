import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../application/manage_players_core_page/manage_scores_bloc.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/entities/score_entity.dart';
import 'edit_player_score_widget_stfull.dart';
class EditPlayersScoreStepper extends StatefulWidget {
  final Map<PlayerEntity, ScoreEntity> playerScores;
  final Function(UpdatePlayerScoreEvent) onUpdateScore;

  const EditPlayersScoreStepper({
    super.key,
    required this.playerScores,
    required this.onUpdateScore,
  });

  @override
  State<EditPlayersScoreStepper> createState() =>
      _EditPlayersScoreStepperState();
}

class _EditPlayersScoreStepperState extends State<EditPlayersScoreStepper> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < widget.playerScores.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  bool _canFinish() {
    return _currentStep == widget.playerScores.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final players = widget.playerScores.keys.toList();

    return Stepper(
      currentStep: _currentStep,
      onStepTapped: (int step) => setState(() => _currentStep = step),
      onStepContinue: _nextStep,
      onStepCancel: _previousStep,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (_currentStep > 0)
                ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: Text('Back', style: themeData.textTheme.bodyLarge),
                ),
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(
                  _canFinish() ? 'Finish' : 'Continue',
                  style: themeData.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
      steps: List.generate(players.length, (index) {
        final player = players[index];
        return Step(
          title: Text(player.name),
          content: SizedBox(
            height: 80,
            child: Center(
              child: EditPlayerStateWidget(
                playerId: player.id,
                onUpdateScore: widget.onUpdateScore,
              ),
            ),
          ),
        );
      }),
    );
  }
}