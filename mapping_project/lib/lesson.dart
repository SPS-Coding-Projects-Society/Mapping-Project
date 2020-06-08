class Lesson {
  final String subject;
  final String room;
  final String teacher;
  final String time;

  Lesson({this.subject, this.room, this.teacher, this.time});

  factory Lesson.fromString(String string) {
    var details = string.split(', ');
    return Lesson(
      subject: details[0],
      room: details[1],
      teacher: details[2],
      time: details[3],
    );
  }

  void output() {
    print("subject: $subject | room: $room | teacher: $teacher | time: $time");
  }
}
