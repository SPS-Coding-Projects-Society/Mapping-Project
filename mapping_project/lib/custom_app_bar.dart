import 'package:flutter/material.dart';

class CustomAppBar {
  static void _pushSettingsPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/settings');
  }

  static void _pushLessonsPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/lessons');
  }

  static void _pushDirectionsPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/directionsSummary');
  }

  static void _pushHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/');
  }

  static void _pushTannoyPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/tannoy');
  }

  static void _pushSavedLocsPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/savedLocs');
  }

  static AppBar create(BuildContext context, String title) {
    return new AppBar(
      textTheme: Theme.of(context).textTheme,
      brightness: Theme.of(context).brightness,
      backgroundColor: Theme.of(context).appBarTheme.color,
      title: Text(title),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(Icons.menu),
          onSelected: (value) {
            switch (value) {
              case "lessons":
                _pushLessonsPage(context);
                break;
              case "settings":
                _pushSettingsPage(context);
                break;
              case "directions":
                _pushDirectionsPage(context);
                break;
              case "home":
                _pushHomePage(context);
                break;
              case "tannoy":
                _pushTannoyPage(context);
                break;
              case "savedLocs":
                _pushSavedLocsPage(context);
                break;
              default:
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "home",
              child: Text("Home Page"),
            ),
            const PopupMenuItem<String>(
              value: "savedLocs",
              child: Text("Saved Locations"),
            ),
            const PopupMenuItem<String>(
              value: "directions",
              child: Text("Navigation"),
            ),
            const PopupMenuItem<String>(
              value: "settings",
              child: Text("Settings"),
            ),
            const PopupMenuItem<String>(
              value: "lessons",
              child: Text("Upcoming Lessons"),
            ),
            const PopupMenuItem<String>(
              value: "tannoy",
              child: Text("Tannoy Notices"),
            ),
          ],
        )
      ],
    );
  }
}
