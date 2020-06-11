import 'package:flutter/material.dart';

void main() {
  runApp(SavedLocs(
    ["Room 101", "Room B6", "Room C5", "Computer Gallery"], //REPLACE THIS WITH THE LIST OF LOCATIONS
  ));
}

class SavedLocs extends StatefulWidget {
final List<String> items;
SavedLocs(this.items);

  

@override
_SavedLocsState createState() => _SavedLocsState(items);
 }


class _SavedLocsState extends State<SavedLocs> {



final List<String> items;

_SavedLocsState(this.items);

  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },

        separatorBuilder: (context, index){

          return Divider();
  },
        ),
  ),

  

  floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: (){addItem();}
                ),
                FloatingActionButton(
                  onPressed: (){removeItem();},
                  child: Icon(Icons.remove),
                )
              ],
            ),
          )

  
  );
   }

  

  
  void removeItem(){
    createAlertDialog(context, false).then((onValue){
      setState(() {
      items.remove(onValue);
    });
    });
  }

  void addItem(){
    createAlertDialog(context, true).then((onValue){
      setState(() {
      items.add(onValue);
    });
    });
    
  }

  Future<String> createAlertDialog (BuildContext context, bool addorremove)
  {
    TextEditingController customController = TextEditingController();
    
    String adder = "remove";
    if(addorremove == true){
      adder = "add";
    }
    

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Enter location to $adder:"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());

            },
          )
        ],
      );
    });
  }

  

}


