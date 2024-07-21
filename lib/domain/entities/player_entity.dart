import 'package:hive/hive.dart';
part 'player_entity.g.dart';
@HiveType(typeId: 1)
class PlayerEntity extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  int score;
  @HiveField(3)
  int iconId;
  PlayerEntity({required this.id, required this.name, this.score = 0, required this.iconId});
}