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
    Navigator.of(context).pushReplacementNamed('tannoy');
  }

  static AppBar create(BuildContext context, String title) {
    return new AppBar(
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
              default:
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "home",
              child: Text("Home Page"),
            ),
            const PopupMenuItem<String>(
              value: "directions",
              child: Text("Directions Page"),
            ),
            const PopupMenuItem<String>(
              value: "settings",
              child: Text("Settings Page"),
            ),
            const PopupMenuItem<String>(
              value: "lessons",
              child: Text("Lessons Page"),
            ),
            const PopupMenuItem<String>(
              value: "tannoy",
              child: Text("Tannoy Page"),
            ),
          ],
        )
      ],
    );
  }
}
