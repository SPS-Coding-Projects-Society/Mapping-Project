import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primaryColor: Colors.white,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context,theme){
        return new MaterialApp(
          title: 'Settings',
          theme: theme,
          darkTheme: ThemeData.dark(),
          home: Settings(),
        );
      },

    );

  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class SettingsState extends State<Settings> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  bool _metricImp = false;
  bool _darkMode = false;
  String _accountName = "";
  // #enddocregion RWS-var
  // #docregion _buildSuggestions
  Widget _buildOptions() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: FlatButton(
            child: Text(
              "Logout from account: " + _accountName,
              style: _biggerFont,
            ),
            onPressed: () {
              logOut();
            },

          )
        ),

      SwitchListTile(
        title: Text(
        _metricImp ?  "Imperial" : "Metric",
        style: _biggerFont),
        value: _metricImp,
        activeColor: Colors.blueGrey,
        activeTrackColor: Colors.blueGrey.shade200,
        inactiveTrackColor: Colors.blueGrey.shade200,
        inactiveThumbColor: Colors.blueGrey,
        onChanged: (bool newValue) {
        setState(() {
          _metricImp = newValue;
          });
        },
        ),
        SwitchListTile(
          title: Text(
              _darkMode ?  "Light Mode" : "Dark Mode",
              style: _biggerFont),
          value: _darkMode,
          activeColor: Colors.blueGrey,
          activeTrackColor: Colors.blueGrey.shade200,
          inactiveTrackColor: Colors.blueGrey.shade200,
          inactiveThumbColor: Colors.blueGrey,
          onChanged: (bool newValue) {
            setState(() {
              _darkMode = newValue;
            });
            changeBrightness();
          },
        ),
      ],
    );
  }
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark ? Brightness.light: Brightness.dark);
  }
  // #enddocregion _buildSuggestions

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _buildOptions(),
    );
  }
// #enddocregion RWS-build
  void logOut() {
  }
}


class Settings extends StatefulWidget {
  @override
  SettingsState createState() => new SettingsState();
}