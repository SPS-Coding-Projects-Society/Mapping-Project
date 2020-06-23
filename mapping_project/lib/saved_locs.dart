import 'package:flutter/material.dart';

//All it needs for input is a List<string>, 
//function returnList() returns updatedlist upon execution
//could add functionality for reading/writing to txt file?
//Lines 7 to 35 are purely for debugging

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: SavedLocs(["Room 101", "Room B6", "Room P5", "Computer Gallery"]),
    );
  }
}





class SavedLocs extends StatefulWidget {//Creates Stateful SavedLocs, allows for adding and removing locations
final List<String> items;
SavedLocs(this.items);

  

@override
_SavedLocsState createState() => _SavedLocsState(items);
 }


class _SavedLocsState extends State<SavedLocs> {//Actual savedlocs ofc



final List<String> userLocs;

_SavedLocsState(this.userLocs);

  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.separated(
        itemCount: userLocs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userLocs[index]),
          ); //Shows the list of saved locs, updates quickly and efficiently :)
        },

        separatorBuilder: (context, index){

          return Divider();
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
                  child: Icon(Icons.add),
                  onPressed: (){addItemOnValue();}
                ),
                FloatingActionButton(
                  onPressed: (){removeItemOnValue();},
                  child: Icon(Icons.remove),
                )
              ],
            ),
          )

  
  );
   }

  

  
  void removeItemOnValue(){//Removes item from list when entered by user
    createPopupBox(context, false).then((onValue){
      setState(() {
      userLocs.remove(onValue);
    });
    });
  }

  void addItemOnValue(){//Adds item to list when entered by user
    createPopupBox(context, true).then((onValue){
      setState(() {
      userLocs.add(onValue);
    });
    });
    
  }

  List<String> returnList(){//Returns the list of rooms
    return userLocs;
  }

  Future<String> createPopupBox (BuildContext context, bool addorremove) //Creates popup box which allows user to enter the name of the location
  {
    TextEditingController customController = TextEditingController();
    
    String adder = "remove"; //Bit of cosmetics - if user is removing location, says remove etc...
    if(addorremove == true){
      adder = "add";
    }
    

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Enter location to $adder:"),
        content: TextField(
          controller: customController,//CustomController allows me to return Future<String> for this and so I can get the user's input
        ),
        actions: <Widget>[
          MaterialButton(//Creates submit button because it looks neater
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());//Pop! The user's input is taken and relayed to where the function was called from

            },
          )
        ],
      );
    });
  }

  

}

