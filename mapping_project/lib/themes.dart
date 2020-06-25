import 'package:flutter/material.dart';

//search & level in grey
//appbar in gold
//gold dividers
//gold floatingbuttons

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFF575A5D),
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF575A5D),
  accentColor: Color(0xFF919293),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Color(0xFFC7A86A)),
  appBarTheme: AppBarTheme(color: Color(0xFF919293)),
  buttonColor: Color(0xFFC7A86A),
  dividerColor: Color(0xFFC7A86A),
  cardColor: Color(0xFF919293),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFFFFFFF),
  accentColor: Color(0xFF919293),
  appBarTheme: AppBarTheme(color: Color(0xFFFFFFFF)),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Color(0xFFC7A86A)),
  buttonColor: Color(0xFFC7A86A),
  dividerColor: Color(0xFFC7A86A),
  cardColor: Color(0xFFFFFFFF),
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
