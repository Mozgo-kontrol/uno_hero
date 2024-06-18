import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uno_notes/domain/entities/score_entity.dart';
import 'package:uno_notes/presantation/scopes_page/scopes_board_item.dart';
import 'package:uno_notes/presantation/scopes_page/scopes_page.dart';

class ScoreBoardWidget extends StatelessWidget {
  final List<ScoreEntity> scores;
  ScoreBoardWidget({super.key, required this.scores});

  final List<Map<String, dynamic>> scores2 = [
    {'name': 'Lisa', 'score': 10},
    {'name': 'Annia', 'score': 20},
    {'name': 'Tima', 'score': 30},
    {'name': 'Igor', 'score': 50},
    {'name': 'Lena', 'score': 180},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    return Expanded(
      child: Container(
        color: themeData.cardColor,
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: scores.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[600],
              thickness: 1,
              height: 5,
            ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: ScoreBoardItemWidget(score: scores[index],)
            );
          },
        ),
      ),
    );
  }
}