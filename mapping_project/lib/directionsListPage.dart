import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

// directions view
class DirectionsListView extends StatefulWidget {
  @override
  DirectionsListViewState createState() => DirectionsListViewState();
}

class DirectionsListViewState extends State<DirectionsListView> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = getDirections(); // list of text directions
    final List<IconData> icons = getIcons(); // list of icons

    return Scaffold(
      appBar: CustomAppBar.create(context, "Directions List"),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(entries[index]),
                  Icon(icons[index]),
                ]),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  List<String> getDirections() {
    // replicated in directionsPage - make global somehow?
    return <String>[
      "Turn left after 5 metres",
      "Continue straight for 10 metres",
      "Turn right after 8 metres",
      "You have arrived"
    ];
  }

  List<IconData> getIcons() {
    // replicated in directionsPage - make global somehow?
    return <IconData>[
      Icons.arrow_left,
      Icons.arrow_upward,
      Icons.arrow_right,
      Icons.done
    ];
  }
}
