import 'package:flutter/material.dart';
import 'package:sps_map/lessons_page.dart';

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
      home: LessonsPage(),
    );
  }
}
