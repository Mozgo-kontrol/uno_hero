import 'package:hive/hive.dart';
import 'package:uno_notes/domain/entities/player_entity.dart';
part 'tournament_entity.g.dart';
@HiveType(typeId: 0)
class TournamentEntity{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool status;
  @HiveField(3)
  final List<Player> players;
  @HiveField(4)
  final Player winner;

  @override
  String toString() {
    return 'TournamentEntity{id: $id, name: $name, status: $status, players: $players, winner: $winner}';
  }

  TournamentEntity ({required this.winner, required this.name, required this.status,required this.id, required this.players});
}