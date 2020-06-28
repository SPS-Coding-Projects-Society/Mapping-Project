import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'room.dart';

//All it needs for input is a List<string>,
//function returnList() returns updatedlist upon execution
//could add functionality for reading/writing to txt file?
//Lines 7 to 35 are purely for debugging

class SavedLocs extends StatefulWidget {
  //Creates Stateful SavedLocs, allows for adding and removing locations

  @override
  _SavedLocsState createState() => _SavedLocsState();
}

class _SavedLocsState extends State<SavedLocs> {
  //Actual savedlocs ofc

  var userLocs = [
    Room.fromString("Room1", "JJR", "CompLab"),
    Room.fromString("Room2", "JMR", "Rambo's Classroom"),
    Room.fromString("BRGOffice", "Girvo", "office")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.create(context, "Saved Locations"),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: userLocs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(userLocs[index].name),
                subtitle: Text(userLocs[index].description),
              ); //Shows the list of saved locs, updates quickly and efficiently :)
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Theme.of(context).dividerColor,
              );
            },
          ),
        ),
        floatingActionButtonLocation: //Creates pair of floatingActionButtons, + & - on left & right sides of page
            FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: "+",
                  child: Icon(Icons.add),
                  onPressed: () {
                    addItemOnValue();
                  }),
              FloatingActionButton(
                heroTag: "-",
                onPressed: () {
                  removeItemOnValue();
                },
                child: Icon(Icons.remove),
              )
            ],
          ),
        ));
  }

  void removeItemOnValue() {
    //Removes item from list when entered by user
    createPopupBox1(context).then((onValue) {
      setState(() {
        if (onValue != null) {
          userLocs.remove(findRoom(userLocs, onValue));
        }
      });
    });
  }

  Room findRoom(List<Room> l, String name) {
    for (var i = 0; i < l.length; i++) {
      if (l[i].name == name) {
        return l[i];
      }
    }
    return Room.fromString("", "", "");
  }

  void addItemOnValue() {
    //Adds item to list when entered by user
    // String roomname = "a";
    // String description = "c";

    createPopupBox2(context, true, false).then((onValue) {
      setState(() {
        if (onValue != null) {
          userLocs.add(Room.fromString(onValue[0], "b", onValue[1]));
        }
      });
    });

    // createPopupBox(context, true, false).then((onValue) {
    //   setState(() {
    //     if (onValue != null) {
    //       description = onValue;
    //     } else {
    //       description = "help";
    //     }
    //   });
    // });

    //userLocs.add(Room.fromString(roomname, "b", description));
  }

  List<Room> returnList() {
    //Returns the list of rooms
    return userLocs;
  }

  Future<String> createPopupBox1(
    BuildContext context,
  ) //Creates popup box which allows user to enter the name of the location
  {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter location to remove:"),
            content: TextField(
                controller: customController,
                decoration: InputDecoration(labelText: "Room")),
            actions: <Widget>[
              MaterialButton(
                //Creates submit button because it looks neater
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text
                      .toString()); //Pop! The user's inputs are taken and relayed (in a list<string>) to where the function was called from
                },
              )
            ],
          );
        });
  }

  Future<List<String>> createPopupBox2(
      BuildContext context,
      bool addorremove,
      bool
          name) //Creates popup box which allows user to enter the name of the location
  {
    TextEditingController customController = TextEditingController();
    TextEditingController customController2 = TextEditingController();
    List<String> lstr = new List<String>();

    String adder =
        "remove"; //Bit of cosmetics - if user is removing location, says remove etc...
    if (addorremove == true) {
      adder = "add";
    }

    String text2 = "location";
    if (name) {
      text2 = "description";
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter $text2 to $adder:"),
            content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
              TextField(
                controller: customController,
                decoration: InputDecoration(labelText: "Room"),
              ),
              TextField(
                controller: customController2,
                decoration: InputDecoration(labelText: "Description"),
              )
            ])),
            actions: <Widget>[
              MaterialButton(
                //Creates submit button because it looks neater
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  lstr.add(customController.text.toString());
                  lstr.add(customController2.text.toString());
                  Navigator.of(context).pop(
                      lstr); //Pop! The user's inputs are taken and relayed (in a list<string>) to where the function was called from
                },
              )
            ],
          );
        });
  }
}
