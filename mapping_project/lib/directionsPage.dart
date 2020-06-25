import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

// directions view
class DirectionsView extends StatefulWidget {
  @override
  DirectionsViewState createState() => DirectionsViewState();
}

class DirectionsViewState extends State<DirectionsView> {
  int index = 0; // current instruction
  final List<String> entries = getDirections(); // list of text directions
  final List<IconData> icons = getIcons(); // list of icons

  static void _pushDirectionsList(BuildContext context) {
    Navigator.of(context).pushNamed('/directionsList');
  }

  var maps = [
    'assets/images/Whole.svg',
    'assets/images/GTB1-G.svg',
    'assets/images/GTB1-1.svg',
    'assets/images/GTB1-2.svg',
    'assets/images/GTB2-G.svg',
    'assets/images/GTB2-1.svg',
    'assets/images/GTB2-2.svg',
    'assets/images/Milton-G.svg',
    'assets/images/Milton-1.svg',
    'assets/images/Milton-2.svg',
    'assets/images/Milton-3.svg',
    'assets/images/Music-G.svg',
    'assets/images/Music-1.svg',
    'assets/images/Pepys-G.svg',
    'assets/images/Pepys-1.svg',
    'assets/images/Science-G.svg',
    'assets/images/Science-1.svg',
    'assets/images/Science-2.svg',
    'assets/images/Science-3.svg',
  ];

  int floor = 0;
  AnimationController
      _animationController; // Controller of animation of buttons
// List of saved places
  PhotoViewController controller; // Controller of map view
  double scaleCopy = 2.5;

  @override
  void initState() {
    super.initState();
    controller = PhotoViewController()..outputStateStream.listen(listener);
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value) {
    setState(() {
      scaleCopy = value.scale;
    });
  }

  String select(int index) {
    // Selecting map image file by floor
    return maps[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.create(context, "Directions"),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          // map image
          PhotoView.customChild(
            childSize: const Size(500, 350),
            basePosition: Alignment.center,
            initialScale: 0.8, // Initial scale of enlargement
            minScale: 0.8,
            maxScale: 8.0, // Lower boundary of scale of enlargement
            controller: controller,
            backgroundDecoration: BoxDecoration(),
            child: SvgPicture.asset(select(floor), semanticsLabel: 'Map'),
          ),
          //),
          Positioned(
            // Picker to choose floor (It will show up when zoomed)
            top: 15,
            left: 15,
            child: Container(
              height: 150,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(
                    color: Theme.of(context).buttonColor, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CupertinoPicker(
                onSelectedItemChanged: (value) {
                  setState(() {
                    floor = value;
                  });
                },
                itemExtent: 30.0,
                children: <Widget>[
                  Center(child: Text("W")),
                  Center(child: Text("1-G")),
                  Center(child: Text("1-1")),
                  Center(child: Text("1-2")),
                  Center(child: Text("2-G")),
                  Center(child: Text("2-1")),
                  Center(child: Text("2-2")),
                  Center(child: Text("3-G")),
                  Center(child: Text("3-1")),
                  Center(child: Text("3-2")),
                  Center(child: Text("3-3")),
                  Center(child: Text("4-1")),
                  Center(child: Text("4-2")),
                  Center(child: Text("5-1")),
                  Center(child: Text("5-2")),
                  Center(child: Text("6-G")),
                  Center(child: Text("6-1")),
                  Center(child: Text("6-2")),
                  Center(child: Text("6-3")),
                ],
              ),
            ),
          ),

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
                  ),
                ),
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
                        // next instruction
                        setState(() {
                          index =
                              index < entries.length - 1 ? index + 1 : index;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

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
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // text summary
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(getDistRemaining()),
                            Text(getTimeRemaining()),
                          ],
                        ),

                        // to list view button
                        FlatButton(
                          onPressed: () {
                            _pushDirectionsList(context);
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
                        },
                        child: Text('End Navigation',
                            style: TextStyle(
                                color: Theme.of(context).buttonColor,
                                fontSize: 15))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
