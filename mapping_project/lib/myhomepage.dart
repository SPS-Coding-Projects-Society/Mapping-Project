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
  //var _moved = false;

  int floor = 0;

  AnimationController
      _animationController; // Controller of animation of buttons
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List<String> suggestions = [
    "Saved",
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
              childSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.5),
              initialScale: 1.0, // Initial scale of enlargement
              minScale: 1.0,
              maxScale: 8.0, // Lower boundary of scale of enlargement
              controller: controller,
              backgroundDecoration: BoxDecoration(),
              child: SvgPicture.asset(select(floor), semanticsLabel: 'Map'),
            ),
          ),
          Positioned(
            // Floating search bar
            top: MediaQuery.of(context).size.height / 28.1904762,
            right: MediaQuery.of(context).size.width / 27.4285714,
            left: MediaQuery.of(context).size.width / 27.4285714,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width /
                                  27.4285714),
                          hintText: "Search"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            // Picker to choose floor (It will show up when zoomed)
            top: 50 + 2 * (MediaQuery.of(context).size.height / 28.1904762),
            left: MediaQuery.of(context).size.width / 27.4285714,
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
          Positioned(
            // Sliding up pannel for time table
            child: SlidingUpPanel(
              //backdropColor: Theme.of(context).backgroundColor,
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).buttonColor, spreadRadius: 1.0)
              ],
              panel: LessonsCard(),
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
