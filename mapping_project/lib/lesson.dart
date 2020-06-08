//this is a class for each lesson
class Lesson {
  //this just says which variables are needed for each lesson object
  final String subject;
  final String room;
  final String teacher;
  final String time;

  //constructor
  Lesson({this.subject, this.room, this.teacher, this.time});

  //creates a lesson object, given a line from a text file
  factory Lesson.fromString(String string) {
    var details = string.split(', ');
    return Lesson(
      subject: details[0],
      room: details[1],
      teacher: details[2],
      time: details[3],
    );
  }

  //outputs the lesson's details
  void output() {
    print("subject: $subject | room: $room | teacher: $teacher | time: $time");
  }
}
