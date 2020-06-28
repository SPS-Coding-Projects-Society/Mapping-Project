//this is a class for each room
class Room {
  //this just says which variables are needed for each room object
  final String name;
  final String teacher;
  final String description;

  //constructor
  Room({this.name, this.teacher, this.description});

  //creates a room object, given three strings
  factory Room.fromString(String name, String teacher, String description) {
    return Room(name: name, teacher: teacher, description: description);
  }

  //outputs the room's details for testing
  void output() {
    print("name: $name | teacher: $teacher | decription: $description");
  }
}
