import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uno_notes/domain/entities/score_entity.dart';
import 'package:uno_notes/presantation/scopes_page/scopes_page.dart';

class ScoreBoardWidget extends StatelessWidget {
  final List<ScoreEntity> scores2;
  ScoreBoardWidget({super.key, required this.scores2});

  final List<Map<String, dynamic>> scores = [
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
        child: ListView.builder(
          itemCount: scores.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${index + 1}# ${scores[index]['name']}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple[400],
                        ),
                      ),
                      Text(
                        '${scores[index]['score']}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: size.width*0.8,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}