import 'package:flutter/material.dart';
import 'package:mapping_project/saved_locs.dart';
import 'package:provider/provider.dart';
import 'package:mapping_project/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'directionsListPage.dart';
import 'directionsPage.dart';
import 'directionsSummaryPage.dart';
import 'lessons_page.dart';
import 'myhomepage.dart';
import 'settings_page.dart';
import 'tannoy_page.dart';
import 'saved_locs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
          child: MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Chitr',
      theme: themeNotifier.getTheme(),
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
        '/savedLocs': (BuildContext context) => new SavedLocs(),
      },
    );
  }
}
