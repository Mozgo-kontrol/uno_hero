import 'package:flutter/material.dart';

import '../../../domain/entities/score_board_item.dart';

class ScoreBoardItemWidget extends StatelessWidget {
  final ScoreBoardItem score;

  const ScoreBoardItemWidget({super.key, required this.score});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
      const myMap = {
      1: Colors.lightGreen,
      2: Colors.orange,
      3: Colors.black};

    Color? chooseColor(int place, int currentScore) {
      Color? result;
      if(currentScore==0){
        return myMap[3];
      }
      if (place >= 4) {
        return myMap[3];
      }
      if (place == 3) {
        return myMap[2];
      }
      result = myMap[place];
      return result;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${score.currentPosition}#',
              textAlign: TextAlign.left,
              style: themeData.textTheme.bodyLarge?.copyWith(color: chooseColor(score.currentPosition,score.score)) ,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                score.playerName,
                textAlign: TextAlign.center,
                style:  themeData.textTheme.bodyLarge?.copyWith(color: chooseColor(score.currentPosition, score.score)) ,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            '${score.score}',
            style: themeData.textTheme.bodyLarge?.copyWith(color: chooseColor(score.currentPosition, score.score)) ,
          ),
        )
      ],
    );
  }
}
