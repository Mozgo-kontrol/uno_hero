import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/app_localizations.dart';

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
    final localizations = AppLocalizations.fromContext(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(
        errorType,
        style: themeData.textTheme.bodyLarge, // More suitable text style
      ),
      content: Text(message,
        style: themeData.textTheme.bodyMedium, // More suitable text style
      ),
      actions: [
        TextButton( // Use TextButton for a cancel action
          onPressed: onCancel,
          child: Text(localizations?.get("cancel_btn_ad")?? "Cancel", style: themeData.textTheme.bodyMedium),
        ),
        ElevatedButton(
          onPressed: onAgree,
          child: Text(localizations?.get("ok_btn_ad")?? "Ok"),
        ),
      ],
    );
  }
}