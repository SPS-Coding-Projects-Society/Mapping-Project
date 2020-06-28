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
            childSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.5),
            basePosition: Alignment.center,
            initialScale: 1.0, // Initial scale of enlargement
            minScale: 1.0,
            maxScale: 8.0, // Lower boundary of scale of enlargement
            controller: controller,
            backgroundDecoration: BoxDecoration(),
            child: SvgPicture.asset(select(floor), semanticsLabel: 'Map'),
          ),
          //),
          Positioned(
            // Picker to choose floor (It will show up when zoomed)
            top: MediaQuery.of(context).size.height * 0.25 +
                MediaQuery.of(context).size.width / 27.4285714,
            left: MediaQuery.of(context).size.width / 27.4285714,
            right: MediaQuery.of(context).size.width / 27.4285714,
            child: Container(
                height: 3 * (MediaQuery.of(context).size.height / 28.1904762),
                width: MediaQuery.of(context).size.width / 10.2857143,
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
                  itemExtent: MediaQuery.of(context).size.height / 28.1904762,
                  children: <Widget>[
                    Center(child: Text("Whole School")),
                    Center(child: Text("GTB1 Ground Floor")),
                    Center(child: Text("GTB1 First Floor")),
                    Center(child: Text("GTB1 Second Floor")),
                    Center(child: Text("GTB2 Ground Floor")),
                    Center(child: Text("GTB2 First Floor")),
                    Center(child: Text("GTB2 Second Floor")),
                    Center(child: Text("Old Science & Milton Ground Floor")),
                    Center(child: Text("Old Science & Milton First Floor")),
                    Center(child: Text("Old Science & Milton Second Floor")),
                    Center(child: Text("Old Science & Milton Third Floor")),
                    Center(child: Text("Music School Ground Floor")),
                    Center(child: Text("Music School First Floor")),
                    Center(child: Text("Drama Block Ground Floor")),
                    Center(child: Text("Drama Block First Floor")),
                    Center(child: Text("New Science Ground Floor")),
                    Center(child: Text("New Science First Floor")),
                    Center(child: Text("New Science Second Floor")),
                    Center(child: Text("New Science Third Floor")),
                  ],
                )),
          ),

          //top box
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).buttonColor),
                  color: Theme.of(context).cardColor,
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
                  border: Border.all(color: Theme.of(context).buttonColor),
                  color: Theme.of(context).cardColor,
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
      Icons.arrow_back,
      Icons.arrow_upward,
      Icons.arrow_forward,
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
