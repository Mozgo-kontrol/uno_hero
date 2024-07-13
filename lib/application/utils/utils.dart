import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/player_entity.dart';

class Utils {
  static void sortPlayersByScore(List<PlayerEntity> list) {
    list.sort((a, b) => a.score.compareTo(b.score));
  }

  static void sortTournamentsById(List<TournamentEntity> list) {
    list.sort((a, b) => b.id.compareTo(a.id));
  }

  static String makeStringShorter(String name, int? stringLength) {
    int cutTo = 9;
    if (stringLength != null) {
      cutTo = stringLength;
    }
    return name.length <= cutTo ? name : "${name.substring(0, cutTo)}..";
  }

  static List<Locale> supportedLocals =  [
    const Locale('en', 'US'),
    const Locale('ru', 'RU'),
    const Locale('de', 'DE'),
    const Locale('ua', 'UA'),
  ];

  static String dateFormatter(DateTime date){
    // Format the date as "yyyy-MM-dd"
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static Color getRandomColors() {
    List<Color> colors = [Colors.red, Colors.blue, Colors.green];
    colors.shuffle();
    return colors.last;
  }
}
