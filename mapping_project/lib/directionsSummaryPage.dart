import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_app_bar.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

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
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
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
      print(value.scale);
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
          Positioned(
            // Map viewer
            child: PhotoView.customChild(
              initialScale: 1.0, // Initial scale of enlargement
              minScale: 1.0,
              maxScale: 8.0, // Lower boundary of scale of enlargement
              controller: controller,
              backgroundDecoration: BoxDecoration(),
              child: SvgPicture.asset(select(floor), semanticsLabel: 'Map'),
            ),
          ),
          Positioned(
            // Picker to choose floor (It will show up when zoomed)
            top: 100,
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
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withAlpha(230),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                      child: Text(
                        getDestination(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.directions_walk,
                          size: 80,
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
                                    style: TextStyle(fontSize: 18)),
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
