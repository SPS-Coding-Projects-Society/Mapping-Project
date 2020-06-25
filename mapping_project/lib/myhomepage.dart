import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_app_bar.dart';
import 'lessons_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var maps = [
    'assets/images/SPSMAP_Top.svg',
    'assets/images/SPSMAP_3rd.svg',
    'assets/images/SPSMAP_2nd.svg',
    'assets/images/SPSMAP_1st.svg',
    'assets/images/SPSMAP_Ground.svg'
  ];
  //var _moved = false;

  int floor = 0;

  AnimationController
      _animationController; // Controller of animation of buttons
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List<String> suggestions = [
    "Saved",
    "Saved",
    "Saved",
    "Saved",
    "Saved"
  ]; // List of saved places
  PhotoViewController controller; // Controller of map view
  double scaleCopy = 2.5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1500), // Duration of button animation
    );
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
    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.create(context, "Home Page"),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          Positioned(
              // Map viewer
              child: PhotoView.customChild(
            initialScale: 2.5, // Initial scale of enlargement
            minScale: 1.0, // Lower boundary of scale of enlargement
            controller: controller,
            backgroundDecoration: BoxDecoration(),
            child: SvgPicture.asset(select(floor), semanticsLabel: 'Map'),
          )),
          Positioned(
            // Floating search bar
            top: 30,
            right: 15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(
                    color: Theme.of(context).buttonColor, width: 1.0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SimpleAutoCompleteTextField(
                      suggestions: suggestions,
                      key: key,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*PositionedTransition(
            // Floating button for tannoy notice
            rect: _animationController
                .drive(
                  CurveTween(
                    curve: Curves.elasticOut,
                  ),
                )
                .drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB(
                        (size.width - 65), (size.height - 160), 20, 115),
                    end: RelativeRect.fromLTRB(
                        (size.width - 135), (size.height - 160), 90, 115),
                  ),
                ),
            child: FloatingActionButton(
              heroTag: "tannoy",
              child: Icon(Icons.notifications),
              onPressed: () {
                print("pressed");
              },
            ),
          ),
          PositionedTransition(
            // Floating button for saved rooms
            rect: _animationController
                .drive(
                  CurveTween(
                    curve: Curves.elasticOut,
                  ),
                )
                .drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB(
                        (size.width - 65), (size.height - 160), 20, 115),
                    end: RelativeRect.fromLTRB(
                        (size.width - 125), (size.height - 220), 80, 175),
                  ),
                ),
            child: FloatingActionButton(
              heroTag: "rooms",
              child: Icon(Icons.bookmark),
              onPressed: () {
                print("pressed");
              },
            ),
          ),
          PositionedTransition(
            // Floating button for setting
            rect: _animationController
                .drive(
                  CurveTween(
                    curve: Curves.elasticOut,
                  ),
                )
                .drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB(
                        (size.width - 65), (size.height - 160), 20, 115),
                    end: RelativeRect.fromLTRB(
                        (size.width - 65), (size.height - 230), 20, 185),
                  ),
                ),
            child: FloatingActionButton(
              heroTag: "settings",
              child: Icon(Icons.settings),
              onPressed: () {
                print("pressed");
              },
            ),
          ),
          Positioned(
            // Floating button to show other buttons
            bottom: 110,
            right: 15,
            child: FloatingActionButton(
              heroTag: "more",
              child: Icon(Icons.more_vert),
              onPressed: () {
                if (_moved != true) {
                  _animationController.forward();
                  _moved = true;
                } else {
                  _animationController.reverse();
                  _moved = false;
                }
              },
            ),
          ),
          Positioned(
            // Floating button for navigation
            bottom: 110,
            left: 15,
            child: FloatingActionButton(
              heroTag: "navigation",
              child: Icon(Icons.location_on),
              onPressed: () {
                print("pressed");
              },
            ),
          ),*/
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
                    Center(child: Text("T")),
                    Center(child: Text("3")),
                    Center(child: Text("2")),
                    Center(child: Text("1")),
                    Center(child: Text("G")),
                  ],
                )),
          ),
          Positioned(
            // Sliding up pannel for time table
            child: SlidingUpPanel(
              //backdropColor: Theme.of(context).backgroundColor,
              color: Theme.of(context).cardColor,
              /*boxShadow: [
                BoxShadow(
                    color: Theme.of(context).buttonColor, spreadRadius: 1.0)
              ],*/
              panel: LessonsCard(),
              collapsed: Container(),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0)),
            ),
          ),
        ],
      ),
    );
  }
}
