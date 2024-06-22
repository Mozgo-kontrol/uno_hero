
import 'package:hive/hive.dart';
part 'score_entity.g.dart';
@HiveType(typeId: 2)
class ScoreEntity{
  @HiveField(0)
  final int id;
  @HiveField(1)
  int score;
  ScoreEntity({required this.id, required this.score});
}