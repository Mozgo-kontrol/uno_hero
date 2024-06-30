import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:uno_notes/presantation/manage_scopes_page/widget/spinner_widget.dart';

import '../../../application/scope_page/scope_bloc.dart';
import '../../../domain/entities/score_board_item.dart';

class EditPlayersScoreStepper extends StatefulWidget {
  final List<ScoreBoardItem> listOfScoresBoardItems;
  final Function(UpdateOnePlayerScoreEvent) onUpdateScore;

  const EditPlayersScoreStepper({
    super.key,
    required this.onUpdateScore,
    required this.listOfScoresBoardItems,
  });

  @override
  State<EditPlayersScoreStepper> createState() =>
      _EditPlayersScoreStepperState();
}

class _EditPlayersScoreStepperState extends State<EditPlayersScoreStepper> {
  late int _currentStep;
  late Map<int, int> _manageScores;

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _manageScores = HashMap();
    for (var item in widget.listOfScoresBoardItems) {
      _manageScores.putIfAbsent(item.playerId, () => 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  late double value;

  void _nextStep() {
    if (_currentStep < widget.listOfScoresBoardItems.length - 1) {
      setState(() => _currentStep++);
    }
    else if (_currentStep == widget.listOfScoresBoardItems.length - 1) {
      setState(() => _currentStep = 0);
    }
  }

  void updatePlayerScore(int playerId, int newScore) {
    print("update playerId = $playerId and score $newScore");
    widget.onUpdateScore(UpdateOnePlayerScoreEvent(playerId: playerId, updatedScore: newScore));
    setState(() => _manageScores.update(playerId, (value) => newScore));
  }

  String getPlayerScore(int playerId) {
    int result = 0;
    setState(() => result = _manageScores[playerId] ?? 0);
    return (result.isNegative) ? result.toString() : "+$result";
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
    else{
      setState(() => _currentStep = widget.listOfScoresBoardItems.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stepper(
      currentStep: _currentStep,
      onStepTapped: (int step) => setState(() => _currentStep = step),
      onStepContinue: _nextStep,
      onStepCancel: _previousStep,

      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
             // if (_currentStep > 0)
              ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                ),
              ),
            ],
          ),
        );
      },
      steps: List.generate(widget.listOfScoresBoardItems.length, (index) {
        final scoresBoardItem = widget.listOfScoresBoardItems[index];

        return Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(scoresBoardItem.playerName, style: themeData.textTheme.bodyLarge,),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 8),
                child: Text(getPlayerScore(scoresBoardItem.playerId), style: themeData.textTheme.bodyLarge),
              ),
            ],
          ),
          content: SpinnerWidget(
            onUpdateScorePlayer: (newScore) {
              updatePlayerScore(scoresBoardItem.playerId, newScore);
            },
          ),
        );
      }),
    );
  }
}

/*
SizedBox(
height: 80,
child: Center(
child: EditPlayerStateWidget(
playerId: scoresBoardItem.playerId,
onUpdateScore: widget.onUpdateScore,
),
),
),*/
