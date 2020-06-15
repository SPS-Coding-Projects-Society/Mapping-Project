import 'package:flutter/material.dart';

class CustomAppBar {
  final String title;

  CustomAppBar({this.title});

  static AppBar create(String title) {
    return new AppBar(
      title: Text(title),
      actions: <Widget>[IconButton(icon: Icon(Icons.menu), onPressed: null)],
    );
  }
}
