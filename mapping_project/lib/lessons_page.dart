import 'package:flutter/material.dart';
import 'lesson.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'custom_app_bar.dart';

class LessonsPage extends StatefulWidget {
  @override
  //initialises the lessons page state
  LessonsPageState createState() => LessonsPageState();
}

class LessonsPageState extends State<LessonsPage> {
  //loads a text file containing the lesson data from assets
  Future<List<String>> loadLessons() async {
    var s = await rootBundle.loadString('assets/text/lessons.txt');
    var lines = s.split("\n");
    return lines;
  }

  //creates a list of lesson objects
  Widget _buildLessonsList(List<String> lines) {
    var lessons = <Lesson>[];
    lines.forEach((line) {
      lessons.add(Lesson.fromString(line));
    });
    //creates a list view of the lessons
    return ListView.builder(
      itemCount: (lessons.length * 2),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        //returns a divider if odd, or lesson details if even
        if (item.isOdd) return Divider();
        final index = item ~/ 2;
        //creates a list tile for the lesson
        return _buildLessonRow(lessons[index]);
      },
    );
  }

  //builds the list tile for the lesson
  Widget _buildLessonRow(Lesson lesson) {
    return ListTile(
      title: Text(
        //returns the tile header as the subject
        lesson.subject,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      //returns other details as the subtitle
      subtitle: Text(
          "Room: ${lesson.room}\nTeacher: ${lesson.teacher}\nTime: ${lesson.time}"),
    );
  }

  //builds the page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.create(context, "Lessons Page"),
      //builds the lessons list, using data from a text file
      body: FutureBuilder(
          //loads the lessons
          future: loadLessons(),
          //returns the list once the file is loaded, or a progress indicator otherwise
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildLessonsList(snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
