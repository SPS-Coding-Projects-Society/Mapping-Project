import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_app_bar.dart';

// directions view
class SummaryView extends StatefulWidget {
  @override
  SummaryViewState createState() => SummaryViewState();
}

class SummaryViewState extends State<SummaryView> {
  static void _pushDirectionsPage(BuildContext context) {
    Navigator.of(context).pushNamed('/directions');
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
          //Positioned(
          // Map viewer
          //child:
          PhotoView.customChild(
            childSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.5),
            basePosition:
                Alignment.lerp(Alignment.topCenter, Alignment.center, 0.75),
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
            top: 15,
            left: MediaQuery.of(context).size.width / 27.4285714,
            right: MediaQuery.of(context).size.width / 27.4285714,
            child: Container(
                height: 5 * (MediaQuery.of(context).size.height / 28.1904762),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 10.2857143,
                          MediaQuery.of(context).size.height / 42.2857143,
                          0,
                          MediaQuery.of(context).size.height / 42.2857143),
                      child: Text(
                        getDestination(),
                        style: TextStyle(
                            fontSize: 2 *
                                MediaQuery.of(context).size.width /
                                27.4285714),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.directions_walk,
                          size: 2 *
                              (MediaQuery.of(context).size.width / 10.2857143),
                        ),
                        IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                getSummary(),
                                style: TextStyle(fontSize: 18),
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  _pushDirectionsPage(context);
                                },
                                child: const Text('Start Navigation',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Theme.of(context).buttonColor,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getDestination() {
    // TODO: replace
    return "Room 005";
  }

  String getSummary() {
    // TODO: replace
    return "120 metres / 1 minute";
  }
}
