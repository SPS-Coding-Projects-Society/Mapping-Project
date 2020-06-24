import 'package:flutter/material.dart';
import 'package:mapping_project/saved_locs.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'directionsListPage.dart';
import 'directionsPage.dart';
import 'directionsSummaryPage.dart';
import 'lessons_page.dart';
import 'myhomepage.dart';
import 'settings_page.dart';
import 'tannoy_page.dart';
import 'saved_locs.dart';
import 'themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primaryColor: Colors.white,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Home Page',
            theme: lightTheme,
            darkTheme: darkTheme,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => new MyHomePage(),
              '/settings': (BuildContext context) => new Settings(),
              '/lessons': (BuildContext context) => new LessonsPage(),
              '/directionsSummary': (BuildContext context) => new SummaryView(),
              '/directionsList': (BuildContext context) =>
                  new DirectionsListView(),
              '/directions': (BuildContext context) => new DirectionsView(),
              '/homepage': (BuildContext context) => new MyHomePage(),
              '/tannoy': (BuildContext context) => new Tannoy(),
              '/savedLocs': (BuildContext context) => new SavedLocs(),
            },
          );
        });
  }
}
