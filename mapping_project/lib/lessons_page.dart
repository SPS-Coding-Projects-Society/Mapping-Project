import 'package:flutter/material.dart';
import 'package:sps_map/main.dart';
import 'lesson.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class LessonsPage extends StatefulWidget {
  @override
  LessonsPageState createState() => LessonsPageState();
}

class LessonsPageState extends State<LessonsPage> {
  Future<List<String>> loadLessons() async {
    var s = await rootBundle.loadString('assets/lessons.txt');
    var lines = s.split("\n");
    return lines;
  }

  Widget _buildLessonsList(List<String> lines) {
    var lessons = <Lesson>[];
    try {
      lines.forEach((line) {
        print(line);
        print("NEW LINE");
        lessons.add(Lesson.fromString(line));
      });

      return ListView.builder(
        itemCount: (lessons.length * 2),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();
          final index = item ~/ 2;

          return _buildLessonRow(lessons[index]);
        },
      );
    } catch (e) {
      return Text(e.toString());
    }
  }

  Widget _buildLessonRow(Lesson lesson) {
    return ListTile(
      title: Text(
        lesson.subject,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(
          "Room: ${lesson.room}\nTeacher: ${lesson.teacher}\nTime: ${lesson.time}"),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Lessons"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.swap_horiz),
              onPressed: () {
                return MyApp(Brightness.dark);
              })
        ],
      ),
      body: FutureBuilder(
          future: loadLessons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildLessonsList(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
