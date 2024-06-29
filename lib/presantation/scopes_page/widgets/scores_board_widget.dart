import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uno_notes/presantation/scopes_page/widgets/scopes_board_item.dart';

import '../../../domain/entities/score_board_item.dart';

class ScoreBoardWidget extends StatelessWidget {
  final List<ScoreBoardItem> scores;
  const ScoreBoardWidget({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Expanded(
      child: Container(
        color: themeData.cardColor,
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          shrinkWrap:(scores.length>=8)? false : true,
          physics: (scores.length >=8)? null : const NeverScrollableScrollPhysics(),
          itemCount: scores.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 5,
              indent: 16,
              endIndent: 16,
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