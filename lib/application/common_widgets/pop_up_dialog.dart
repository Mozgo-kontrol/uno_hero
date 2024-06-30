import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Improved version of the code
class TopPopupDialog extends StatelessWidget {
  final String errorType; // Renamed for clarity
  final String message;   // Renamed for clarity
  final VoidCallback onAgree; // Use VoidCallback for clarity
  final VoidCallback onCancel; // Use VoidCallback for clarity

  const TopPopupDialog({
    super.key,
    required this.errorType,
    required this.message,
    required this.onAgree,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(
        errorType,
        style: themeData.textTheme.headlineMedium, // More suitable text style
      ),
      content: Text(message,
        style: themeData.textTheme.bodyLarge, // More suitable text style
      ),
      actions: [
        TextButton( // Use TextButton for a cancel action
          onPressed: onCancel,
          child: Text("Cancel", style: themeData.textTheme.labelLarge),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: onAgree,
          child: Text("Ok", style: themeData.textTheme.labelLarge),
        ),
      ],
    );
  }
}