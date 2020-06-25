import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

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

  var userLocs = ["Room 1", "Room 2", "Room 3"];

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
                title: Text(userLocs[index]),
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
    createPopupBox(context, false).then((onValue) {
      setState(() {
        if (onValue != null) {
          userLocs.remove(onValue);
        }
      });
    });
  }

  void addItemOnValue() {
    //Adds item to list when entered by user
    createPopupBox(context, true).then((onValue) {
      setState(() {
        if (onValue != null) {
          userLocs.add(onValue);
        }
      });
    });
  }

  List<String> returnList() {
    //Returns the list of rooms
    return userLocs;
  }

  Future<String> createPopupBox(
      BuildContext context,
      bool
          addorremove) //Creates popup box which allows user to enter the name of the location
  {
    TextEditingController customController = TextEditingController();

    String adder =
        "remove"; //Bit of cosmetics - if user is removing location, says remove etc...
    if (addorremove == true) {
      adder = "add";
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter location to $adder:"),
            content: TextField(
              controller:
                  customController, //CustomController allows me to return Future<String> for this and so I can get the user's input
            ),
            actions: <Widget>[
              MaterialButton(
                //Creates submit button because it looks neater
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text
                      .toString()); //Pop! The user's input is taken and relayed to where the function was called from
                },
              )
            ],
          );
        });
  }
}
