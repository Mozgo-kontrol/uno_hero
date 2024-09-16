import 'package:flutter/material.dart';
import 'package:uno_notes/presantation/create_tournament_page/widgets/player_icon.dart';

import '../../../domain/entities/player_entity.dart';
import 'CustomCardShape.dart';

class GridCustomPlayerList extends StatelessWidget {
  final List<PlayerEntity> players;
  final void Function(int playerId, String playerName) onCardTap;
  final VoidCallback onPressed;

   const GridCustomPlayerList({
    super.key,
    required this.players,
    required this.onPressed,
     required this.onCardTap,
  });

  static Widget buildAddCard(VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: const Card(
        shape: CustomCardShape(shapeColor: Colors.blue),
        child: SizedBox.square(
          dimension: 40,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 32),
                SizedBox(height: 16),
                Text('Add Player'),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static Widget buildCard(PlayerEntity playerEntity, void Function(int, String) onTap) {
    return  GestureDetector(
      onLongPress: () => onTap(playerEntity.id, playerEntity.name),
      child: Card(
        shape: const CustomCardShape(shapeColor: Colors.blue),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double iconSize = constraints.maxWidth * 0.65; // Adjust the factor as needed

            return SizedBox.square(
              dimension: constraints.maxWidth, // Use the available width
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    PlayerIcon(iconIndex: playerEntity.iconId, iconHeight: iconSize , iconWidth: iconSize),
                    const SizedBox(height: 2),
                    Text(playerEntity.name, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      buildAddCard(onPressed), // Pass onAddPlayer
      ...players.reversed.map((player) => buildCard(player, onCardTap)),
    ];
    bool shouldScroll = cards.length <= 9;
    return GridView.builder(
      physics: (shouldScroll) ? const NeverScrollableScrollPhysics(): null, // Disable scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: cards.length,
      itemBuilder: (context, index) => cards[index],
    );
  }
}
