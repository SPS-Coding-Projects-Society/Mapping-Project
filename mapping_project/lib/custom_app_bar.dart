import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'lessons_page.dart';

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
              default:
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: "lesson",
              child: Text("Lessons Page"),
            ),
            const PopupMenuItem<String>(
              value: "settings",
              child: Text("Settings Page"),
            ),
          ],
        )
      ],
    );
  }
}
