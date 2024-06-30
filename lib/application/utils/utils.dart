import '../../domain/entities/player_entity.dart';

class Utils{
  static void sortPlayersByScore(List<PlayerEntity> list){
    list.sort((a, b) => a.score.compareTo(b.score));
  }

  static String convertPlayerName(String name){
    return name.length<=9 ? name : "${name.substring(0, 9)}..";
  }
}