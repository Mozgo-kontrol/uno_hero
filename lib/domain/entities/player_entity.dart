import 'dart:ffi';

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
  PlayerEntity({required this.id, required this.name, this.score = 0});
}