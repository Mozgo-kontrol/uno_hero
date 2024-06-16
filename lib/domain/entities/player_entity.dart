import 'package:hive/hive.dart';
part 'player_entity.g.dart';
@HiveType(typeId: 1)
class PlayerEntity{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  PlayerEntity({required this.id, required this.name});
}