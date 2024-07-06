import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Improved version of the code
class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings= {}; // Initialize the map

  AppLocalizations(this.locale);

  // Consider renaming 'of' to 'fromContext' for clarity
  static AppLocalizations? fromContext(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);}

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Use a more concise way to cast values to String
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  // Rename 'translate' to 'get' for a more common localization pattern
  String? get(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  // Store supported locales in a Set for efficient lookup
  static final Set<String> _supportedLocales = {'en', 'ru'}.toSet();

  @override
  bool isSupported(Locale locale) {
    return _supportedLocales.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}