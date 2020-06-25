//import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'custom_app_bar.dart';
import 'notice.dart';

class Tannoy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TannoyState();
  }
}

class TannoyState extends State<Tannoy> {
  // 2
  Future<List<String>> loadNotices() async {
    var s = await rootBundle.loadString('assets/text/tannoy.txt');
    var lines = s.split("\n");
    return lines;
  }

  //creates a list of notice objects
  Widget _buildNoticesList(List<String> lines) {
    var notices = <Notice>[];
    for (var i = 0; i < lines.length; i++) {
      notices.add(Notice.fromString(lines[i], lines[i + 1]));
      i += 2;
    }
    //creates a list view of the notices
    return ListView.builder(
      itemCount: (notices.length * 2),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        //returns a divider if odd, or notice details if even
        if (item.isOdd)
          return Divider(
            color: Theme.of(context).dividerColor,
          );
        final index = item ~/ 2;
        //creates a list tile for the notice
        return _buildNoticeRow(notices[index]);
      },
    );
  }

  //builds the list tile for the notice
  Widget _buildNoticeRow(Notice notice) {
    return ListTile(
      title: Text(
        //returns the tile header as the subject
        notice.title,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      //returns other details as the subtitle
      subtitle: Text(notice.body),
    );
  }

  //builds the page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.create(context, "Notices Page"),
      backgroundColor: Theme.of(context).backgroundColor,
      //builds the notices list, using data from a text file
      body: FutureBuilder(
          //loads the notices
          future: loadNotices(),
          //returns the list once the file is loaded, or a progress indicator otherwise
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildNoticesList(snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
