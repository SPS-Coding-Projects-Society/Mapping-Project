import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'custom_app_bar.dart';

// #docregion RWS-var
class SettingsState extends State<Settings> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  bool _metricImp =
      false; //the following three variables should be global variables -- to be implemented later
  bool _darkMode = false;
  String _accountName = "";

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
            )),
        SwitchListTile(
          //Metric imperial tile
          title: Text(
              _metricImp
                  ? "Imperial"
                  : "Metric", //Alternates between the two options
              style: _biggerFont),
          value: _metricImp,
          activeColor: Colors.blueGrey,
          activeTrackColor: Colors.blueGrey.shade200,
          inactiveTrackColor: Colors.blueGrey.shade200,
          inactiveThumbColor: Colors
              .blueGrey, //changing the track colours so they look the same when on/off since this is not an on/off switch
          onChanged: (bool newValue) {
            setState(() {
              _metricImp = newValue; //assigning new value
            });
          },
        ),
        SwitchListTile(
          //as above^
          title:
              Text(_darkMode ? "Light Mode" : "Dark Mode", style: _biggerFont),
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
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);

    //the widget called above that uses the 'Dynamic Theme' package to actively change the theme - rebuilding the whole thing every time you switch
  }
  // #enddocregion _buildSuggestions

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold just arranges the options nicely
      appBar: CustomAppBar.create(context, "Settings Page"),
      body: _buildOptions(),
    );
  }

// #enddocregion RWS-build
  void logOut() {
    //will include a widget that will carry out the logging out process.
    // -- to be implemented later
  }
}

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => new SettingsState();
}
