import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopPopupDialog extends StatelessWidget {
  const TopPopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AlertDialog(
      // Customize the shape if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(
        "Fehler",
        style: themeData.textTheme.headlineLarge,
      ),
      content: Text(
        "The title cannot be empty and you need at least two players.",
        style: themeData.textTheme.displayLarge,
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            elevation: 0,
          ),
          onPressed: () => Navigator.pop(context),
          child: Text("Ok", style: themeData.textTheme.displayLarge,),
        ),
      ],
    );
  }
}
