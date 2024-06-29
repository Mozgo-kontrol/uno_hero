import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../application/manage_players_core_page/manage_scores_bloc.dart';
import '../../../application/scope_page/scope_bloc.dart';

class EditPlayerStateWidget extends StatefulWidget {
  final Function(UpdateOnePlayerScoreEvent) onUpdateScore;
  final int playerId;

  const EditPlayerStateWidget({
    super.key,
    required this.onUpdateScore,
    required this.playerId,
  });

  @override
  State<EditPlayerStateWidget> createState() => _EditPlayerStateWidgetState();
}

class _EditPlayerStateWidgetState extends State<EditPlayerStateWidget> {
  late final TextEditingController _scoreTextFieldController;

  @override
  void initState() {
    super.initState();
    _scoreTextFieldController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _scoreTextFieldController.dispose();
    super.dispose();
  }

  void _updateScore() {
    final scoreText = _scoreTextFieldController.text;
    if (scoreText.isNotEmpty) {
      int changedScore = 0;
      try {
        changedScore = int.parse(scoreText);
      } catch (e) {
        print('Error parsing number: $e');
        // Handle the exception, e.g., display an error message to the user
      }
      widget.onUpdateScore(
        UpdateOnePlayerScoreEvent(
          updatedScore: changedScore,
          playerId: widget.playerId,
        ),
      );
      _scoreTextFieldController.text = '0'; // Reset to 0 after updating
    }
  }

  void _addScoreButton() {
    final scoreText = _scoreTextFieldController.text;
    if (scoreText.isNotEmpty) {
      int changedScore = 0;
      try {
        changedScore = int.parse(scoreText);
      } catch (e) {
        print('Error parsing number: $e');
        // Handle the exception, e.g., display an error message to the user
      }
      changedScore = changedScore + 5;
      _scoreTextFieldController.text = changedScore.toString();
      widget.onUpdateScore(
        UpdateOnePlayerScoreEvent(
          updatedScore: changedScore,
          playerId: widget.playerId,
        ),
      );
    }
  }

  void _removeScoreButton() {
    final scoreText = _scoreTextFieldController.text;
    if (scoreText.isNotEmpty) {
      int changedScore = 0;
      try {
        changedScore = int.parse(scoreText);
      } catch (e) {
        print('Error parsing number: $e');
        // Handle the exception, e.g., display an error message to the user
      }
      if (changedScore < 5) {
        changedScore = 0;
      }
      else if (changedScore > 0) {
        changedScore = changedScore - 5;
      }

      _scoreTextFieldController.text = changedScore.toString();
      widget.onUpdateScore(
        UpdateOnePlayerScoreEvent(
          updatedScore: changedScore,
          playerId: widget.playerId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 80, // Increased icon size
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {
            _removeScoreButton(); // TODO: Implement logic to decrease score
            print('Remove score');
          },
        ),
        SizedBox(
          width: 80, // Adjusted width for better input visibility
          child: TextField(
            style: themeData.textTheme.bodyMedium,
            controller: _scoreTextFieldController,
            maxLengthEnforcement:  MaxLengthEnforcement.enforced,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            // Center the text
            onSubmitted: (_) => _updateScore(),
            // Update on submit
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8), // Added padding
            ),
          ),
        ),
        IconButton(
          iconSize: 80, // Increased icon size for better usability
          icon: const Icon(Icons.add_circle, color: Colors.green),
          onPressed: () {
            _addScoreButton(); // TODO: Implement logic to increase score
            print('Add score');
          },
        ),
      ],
    );
  }
}
