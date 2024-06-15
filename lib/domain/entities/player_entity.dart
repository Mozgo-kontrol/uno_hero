import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Player{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  Player({required this.id, required this.name});
}