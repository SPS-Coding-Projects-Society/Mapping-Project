import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'lessons_page.dart';
import 'directionsSummaryPage.dart';
import 'myhomepage.dart';
import 'tannoy.dart';

class CustomAppBar {
  static void _pushSettingsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => MyApp()),
    );
  }

  static void _pushLessonsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => LessonsPage()),
    );
  }

  static void _pushDirectionsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => SummaryView()),
    );
  }

  static void _pushHomePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
    );
  }

  static void _pushTannoyPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => Tannoy()),
    );
  }

  static AppBar create(BuildContext context, String title) {
    return new AppBar(
      title: Text(title),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(Icons.menu),
          onSelected: (value) {
            switch (value) {
              case "lesson":
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
