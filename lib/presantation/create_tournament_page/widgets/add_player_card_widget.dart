import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    return Card( // Wrap the content in a Card widget for a more polished look
      child: InkWell( // Make the entire card tappable
        onTap: onPressed,
        child: SizedBox(
          height: 50,
          child: Center( // Center the text horizontally
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
