import 'package:hive/hive.dart';
import 'package:uno_notes/domain/entities/player_entity.dart';
part 'tournament_entity.g.dart';
@HiveType(typeId: 0)
class TournamentEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  bool isFinished = false;
  @HiveField(3)
  List<PlayerEntity> players = [];
  @HiveField(4)
  PlayerEntity winner = PlayerEntity(id: 0, name: "...");

  @override
  String toString() {
    return 'TournamentEntity{id: $id, title: $title, isFinished: $isFinished, players: $players, winner: $winner}';
  }
  TournamentEntity({ required this.id, required this.title, required this.players});
}