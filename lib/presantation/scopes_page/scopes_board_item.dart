
import 'package:flutter/material.dart';

import '../../domain/entities/score_entity.dart';

class ScoreBoardItemWidget extends StatelessWidget {
  final ScoreEntity score;
  const ScoreBoardItemWidget({super.key, required this.score});

   static const TextStyle boldStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,// Example font family
    fontWeight: FontWeight.bold,
  );
  static const TextStyle winnerBoldStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,// Example font family
    color: Colors.lightGreen,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle secoundPlaceBoldStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,// Example font family
    color: Colors.orange,
    fontWeight: FontWeight.bold,
  );
  static const myMap = {1: winnerBoldStyle, 2 : secoundPlaceBoldStyle, 3: boldStyle};

  TextStyle? chooseColor(int place){
    TextStyle? result;
    if(place>=4){
      return myMap[3];
    }
    if(place==3){
      return myMap[2];
    }
    result = myMap[place];
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${score.currentPosition}#',
          textAlign: TextAlign.left,
          style: chooseColor(score.currentPosition),
        ),
        Text(
        score.playerName,
          style: chooseColor(score.currentPosition),
        ),
        Text(
          '${score.score}',
          style: chooseColor(score.currentPosition),
        ),
      ],
    );
  }
}
