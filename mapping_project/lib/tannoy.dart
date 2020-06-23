//import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'custom_app_bar.dart';

class Tannoy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TannoyState();
  }
}

class TannoyState extends State<Tannoy> {
  // 2
  List<String> _notices = [];

  Future<List<String>> _loadNotices() async {
    List<String> questions = [];
    await rootBundle.loadString('assets/text/tannoy.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        questions.add(i);
      }
    });
    return questions;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    List<String> questions = await _loadNotices();
    setState(() {
      _notices = questions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.create(context, "Tannoy Notices"),
      body: Center(
        child: Container(
          //color: Colors.green,
          width: 350,
//          child: ListView.builder(
//            itemCount: _notices.length,
//            itemBuilder: (context, index) {
//              return Text(_notices[index]);
//            },
//          ),
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _notices.length,
              itemBuilder: (context, index) {
                return Text(_notices[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
