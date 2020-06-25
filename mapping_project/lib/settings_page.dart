import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_app_bar.dart';
import 'themes.dart';

// #docregion RWS-var
class SettingsState extends State<Settings> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  bool _metricImp =
      false; //the following three variables should be global variables -- to be implemented later
  var _darkTheme = true;
  String _accountName = "";

  Widget _buildOptions() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
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
          activeColor: Theme.of(context).buttonColor,
          activeTrackColor: Theme.of(context).accentColor,
          inactiveTrackColor: Theme.of(context).accentColor,
          inactiveThumbColor: Theme.of(context)
              .buttonColor, //changing the track colours so they look the same when on/off since this is not an on/off switch
          onChanged: (bool newValue) {
            setState(() {
              _metricImp = newValue; //assigning new value
            });
          },
        ),
        SwitchListTile(
          //as above^
          title:
              Text(_darkTheme ? "Light Mode" : "Dark Mode", style: _biggerFont),
          value: _darkTheme,
          activeColor: Theme.of(context).buttonColor,
          activeTrackColor: Theme.of(context).accentColor,
          inactiveTrackColor: Theme.of(context).accentColor,
          inactiveThumbColor: Theme.of(context).buttonColor,
          onChanged: (bool newValue) {
            setState(() {
              _darkTheme = newValue;
            });
            onThemeChanged(newValue, themeNotifier);
          },
        ),
      ],
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold just arranges the options nicely
      appBar: CustomAppBar.create(context, "Settings Page"),
      backgroundColor: Theme.of(context).backgroundColor,
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
