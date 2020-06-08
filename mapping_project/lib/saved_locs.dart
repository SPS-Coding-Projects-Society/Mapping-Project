import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SavedLocs(
    items: ["Room 101", "Room B6", "Room P5", "Computer Gallery"], //REPLACE THIS WITH THE LIST OF LOCATIONS
  ));
}

class SavedLocs extends StatelessWidget {
  final List<String> items;

  SavedLocs({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Saved Locations';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}