
import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class ScoreEntity{

  @HiveField(0)
  final int playerId;
  @HiveField(1)
  String playerName;
  @HiveField(1)
  final int score;

  ScoreEntity({required this.playerId, required this.score,required this.playerName});

}