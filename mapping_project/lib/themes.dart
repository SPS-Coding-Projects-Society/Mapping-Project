import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFF575A5D),
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF575A5D),
  accentColor: Color(0xFF919293),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Color(0xFFC7A86A)),
  buttonColor: Color(0xFFC7A86A),
  dividerColor: Color(0x919293),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFFFFFFF),
  accentColor: Color(0xFF919293),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Color(0xFFC7A86A)),
  buttonColor: Color(0xFFC7A86A),
  dividerColor: Color(0x919293),
);

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
