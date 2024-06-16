import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/player_entity.dart';
import 'add_player_card_widget.dart';

// Improved AddPlayerWidget
class AddPlayerWidget extends StatelessWidget {
  final List<PlayerEntity> players;

  const AddPlayerWidget({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        final player = players[index]; // Store the player for readability
        return AddPlayerCardWidget(
          id: player.id,
          name: player.name,
          onPressed: () => {
            // Handle player selection here, e.g., navigate to a details screen
            print('Selected player: ${player.name}')
          },
        );
      },
    );
  }
}