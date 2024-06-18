import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/score_entity.dart';

class ScoreBoardItemWidget extends StatelessWidget {
  final ScoreEntity score;
  const ScoreBoardItemWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${score.currentPosition}#',
          style: TextStyle(
            fontSize: 20,
            color: Colors.purple[400],
          ),
        ),
        Text(
        score.playerName,
          style: TextStyle(
            fontSize: 20,
            color: Colors.purple[400],
          ),
        ),
        Text(
          '${score.score}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.purple[400],
          ),
        ),
      ],
    );
  }
}
