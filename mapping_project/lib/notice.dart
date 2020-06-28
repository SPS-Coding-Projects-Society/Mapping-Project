//this is a class for each lesson
class Notice {
  //this just says which variables are needed for each lesson object
  final String title;
  final String body;

  //constructor
  Notice({this.title, this.body});

  //creates a lesson object, given a line from a text file
  factory Notice.fromString(String title, String body) {
    return Notice(
      title: title,
      body: body,
    );
  }

  //outputs the lesson's details
  void output() {
    print("title: $title | body: $body");
  }
}
