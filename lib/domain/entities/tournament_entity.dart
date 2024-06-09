import 'package:uno_notes/domain/entities/player_entity.dart';

class Tournament{

  final int id;
  final String name;
  final bool status;
  final List<Player> players;
  final Player winner;

  Tournament ({required this.winner, required this.name, required this.status,required this.id, required this.players});
}