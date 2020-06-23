import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'custom_app_bar.dart';

// directions view
class DirectionsView extends StatefulWidget {
  @override
  DirectionsViewState createState() => DirectionsViewState();
}

class DirectionsViewState extends State<DirectionsView> {
  int index = 0; // current instruction
  final List<String> entries = getDirections(); // list of text directions
  final List<IconData> icons = getIcons(); // list of icons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.create(context, "Directions"),
      body: Stack(children: <Widget>[
        // map image
        Expanded(
            child: PhotoView(
          imageProvider:
              AssetImage('assets/map.png'), // TODO: replace temporary image
        )),

        //top box
        Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // back button
                      FlatButton(
                        child: Icon(
                          Icons.chevron_left,
                          size: 50,
                        ),
                        onPressed: () {
                          setState(() {
                            index = index > 0 ? index - 1 : index;
                          });
                        }, // previous instruction
                      ),
                      // direction instruction
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // text instruction
                          Text(
                            entries[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          // icon
                          Icon(
                            icons[index],
                            size: 50,
                          )
                        ],
                      ),
                      // next button
                      FlatButton(
                        child: Icon(
                          Icons.chevron_right,
                          size: 50,
                        ),
                        onPressed: () {
                          setState(() {
                            index =
                                index < entries.length - 1 ? index + 1 : index;
                          });
                        }, // next instruction
                      ),
                    ],
                  )),
            )),

        // bottom box
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        )),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // text summary
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(getDistRemaining()),
                                  Text(getTimeRemaining()),
                                ],
                              ),

                              // to list view button
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/list');
                                },
                                child: Icon(
                                  Icons.list,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),

                          // end navigation button
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              }, // TODO: navigation
                              child: Text('End Navigation',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15))),
                        ])))),
      ]),
    );
  }

  static List<String> getDirections() {
    // replicated in directionsListPage - make global somehow? TODO: replace
    return <String>[
      "Turn left after 5 metres",
      "Continue for 10 metres",
      "Turn right after 8 metres",
      "You have arrived"
    ];
  }

  static List<IconData> getIcons() {
    // replicated in directionsListPage - make global somehow? TODO: replace
    return <IconData>[
      Icons.arrow_left,
      Icons.arrow_upward,
      Icons.arrow_right,
      Icons.done
    ];
  }

  String getDistRemaining() {
    // TODO: replace
    return "30 metres";
  }

  String getTimeRemaining() {
    // TODO: replace
    return "40 seconds";
  }
}
