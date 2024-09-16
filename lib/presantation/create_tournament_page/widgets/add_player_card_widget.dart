import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uno_notes/presantation/create_tournament_page/widgets/player_icon.dart';

import 'CustomCardShape.dart';

class AddPlayerCardWidget extends StatelessWidget {
  final int id;
  final String name;
  final VoidCallback onPressed; // Use VoidCallback for button callbacks

  const AddPlayerCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context); // Consider using this if you plan to style the card
    // final size = MediaQuery.of(context).size; // Not used, can be removed

    return Card(
      shape: const CustomCardShape(shapeColor: Colors.blue),// Wrap the content in a Card widget for a more polished look
      child: InkWell( // Make the entire card tappable
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            width: 80,
            child: Center( // Center the text horizontally
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PlayerIcon(iconIndex: 0,),
                  Text(name, style: themeData.textTheme.bodyLarge,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
