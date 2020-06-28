import 'package:flutter/material.dart';
import 'directionsListPage.dart';
import 'directionsPage.dart';
import 'directionsSummaryPage.dart';
import 'lessons_page.dart';
import 'myhomepage.dart';
import 'settings_page.dart';
import 'tannoy.dart';

void main() => runApp(MyApp(Brightness.light));

class MyApp extends StatelessWidget {
  MyApp(this.brightness);

  final Brightness brightness;

  @override
  //because we're inheriting from the StatelessWidget class (which has its own build method), we have to override its build method
  Widget build(BuildContext context) {
    //every build method must contain a BuildContext
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.purple[900], brightness: brightness),
      darkTheme: ThemeData.dark(),

      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new MyHomePage(),
        '/settings': (BuildContext context) => new Settings(),
        '/lessons': (BuildContext context) => new LessonsPage(),
        '/directionsSummary': (BuildContext context) => new SummaryView(),
        '/directionsList': (BuildContext context) => new DirectionsListView(),
        '/directions': (BuildContext context) => new DirectionsView(),
        '/homepage': (BuildContext context) => new MyHomePage(),
        '/tannoy': (BuildContext context) => new Tannoy(),
      },
    );
  }
}
