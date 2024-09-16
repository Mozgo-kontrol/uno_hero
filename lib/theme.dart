import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor =  Colors.white;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Color(0xFFECEFF1);

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _lightIconColor = _lightTextColorPrimary;
  static const Color _darkIconColor = _darkTextColorPrimary;

  static const Color _accentColorDark = Color.fromRGBO(74, 217, 217, 1);
  static const Color _lightAppBarBackgroundColor = Color(0xFFECEFF1);
  static const TextStyle _lightHeadingTextStyle = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: 'Roboto',
      fontSize: 32,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyTextStyle = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 24);

  static const TextStyle _lightBodyMediumTextStyle = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 16);

//Button text style
  static const TextStyle _lightButtonMediumStyle = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 16);

  static final TextStyle _darkButtonMediumStyle =
      _lightButtonMediumStyle.copyWith(color: Colors.blue);

//Button text style
  static final TextStyle _darkThemeHeadingTextStyle =
      _lightHeadingTextStyle.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle =
      _lightBodyTextStyle.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyMediumTextStyle =
      _lightBodyMediumTextStyle.copyWith(color: _darkTextColorPrimary);

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingTextStyle,
    bodyLarge: _lightBodyTextStyle,
    bodyMedium: _lightBodyMediumTextStyle,
    labelMedium: _lightButtonMediumStyle, //Button text style
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkThemeHeadingTextStyle,
    bodyLarge: _darkThemeBodyTextStyle,
    bodyMedium: _darkThemeBodyMediumTextStyle,
    labelMedium: _darkButtonMediumStyle,
  );

  static final ButtonThemeData _buttonTheme = ButtonThemeData(
    // Shape of the button
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // Button padding
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),

    // Button's background color
    buttonColor: Colors.blue,

    // Disabled button's background color
    disabledColor: Colors.grey,

    // Button's text color
    textTheme: ButtonTextTheme.primary,
    // Use predefined text theme for primary buttons

    // Button's elevation
    height: 48.0,

    // Minimum button size
    minWidth: 160.0,

    // Material Tap Target size
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );

  static final ElevatedButtonThemeData _lightElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              // Button background color
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              // Text and icon color
              textStyle: _lightBodyMediumTextStyle,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(49.0)),
              )));
  static final ElevatedButtonThemeData _darkElevatedButtonTheme =
  ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // Button background color
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          // Text and icon color
          textStyle: _lightBodyMediumTextStyle,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10))));

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
        color: _appbarColorLight,
        iconTheme: IconThemeData(color: _lightIconColor)),
    bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight),
    elevatedButtonTheme: _lightElevatedButtonTheme,
    colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: _lightOnPrimaryColor,
        secondary: _accentColorDark,
        primaryContainer: _lightPrimaryVariantColor),
    textTheme: _lightTextTheme,
    buttonTheme: _buttonTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
        color: _appbarColorDark,
        iconTheme: const IconThemeData(color: _darkIconColor)),
    bottomAppBarTheme: BottomAppBarTheme(color: _appbarColorDark),
    elevatedButtonTheme: _darkElevatedButtonTheme,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _accentColorDark,
      onPrimary: _darkOnPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor,
    ),
    textTheme: _darkTextTheme,
    buttonTheme: _buttonTheme,
  );
}
