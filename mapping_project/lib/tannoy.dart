import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

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
      appBar: AppBar(
        //title: Text("Tannoy Notices"),
        //title: Text("Tannoy"),
        title: new Padding (child: new Text ("Tannoy Notices"),
            padding:const EdgeInsets.only(left: 125.0) ),
        centerTitle: false,
        //bottom: PreferredSize(
           // child: Text("Notices"),
            //preferredSize: null),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: () => exit(0),
          color: Colors.white,
        ),
      ),
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
            itemBuilder: (context, index){
              return Text(_notices[index]);
            },
          ),
        ),
        ),
      ),
    );
  }
}
