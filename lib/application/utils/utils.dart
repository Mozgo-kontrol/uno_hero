import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  static List<Locale> supportedLocals = [
    const Locale('en', 'US'),
    const Locale('ru', 'RU'),
    const Locale('de', 'DE'),
    const Locale('ua', 'UA'),
  ];

  static String dateFormatter(DateTime date) {
    // Format the date as "yyyy-MM-dd"
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static Color getRandomColors() {
    List<Color> colors = [Colors.red, Colors.blue, Colors.green];
    colors.shuffle();
    return colors.last;
  }

  static String getIconById(int id) {
    int iconId = id % 19;
    String defaultIcon = 'assets/icons/persons/Astronaut.svg';
    return iconsList[iconId] ?? defaultIcon;
  }

  static Map <int, String> iconsList = {
    1: 'assets/icons/persons/Astronaut.svg',
    2: 'assets/icons/persons/Maid.svg',
    3: 'assets/icons/persons/Artist.svg',
    4: 'assets/icons/persons/Woman-3.svg',
    5: 'assets/icons/persons/Rasta.svg',
    6: 'assets/icons/persons/Surfer.svg',
    7: 'assets/icons/persons/Woman-1.svg',
    8: 'assets/icons/persons/Scientist.svg',
    9: 'assets/icons/persons/Woman-2.svg',
    10: 'assets/icons/persons/Soldier.svg',
    11: 'assets/icons/persons/Woman-4.svg',
    12: 'assets/icons/persons/Pilot-1.svg',
    13: 'assets/icons/persons/Woman-5.svg',
    14: 'assets/icons/persons/Ninja.svg',
    15: 'assets/icons/persons/Woman-6.svg',
    16: 'assets/icons/persons/Man-7.svg',
    17: 'assets/icons/persons/Woman-7.svg',
    18: 'assets/icons/persons/Thief.svg',
  };

  static int getNextIconId(int currentId) {
    return (currentId % iconsList.length) + 1;
  }
}
