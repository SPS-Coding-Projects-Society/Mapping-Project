import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  var maps = ['images/SPSMAP_Top.svg','images/SPSMAP_3rd.svg','images/SPSMAP_2nd.svg','images/SPSMAP_1st.svg','images/SPSMAP_Ground.svg'];
  var _moved = false;
  
  int floor = 0;

  AnimationController _animationController; // Controller of animation of buttons
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List<String> suggestions = ["Saved", "Saved","Saved","Saved","Saved"]; // List of saved places
  PhotoViewController controller; // Controller of map view
  double scaleCopy = 2.5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Duration of button animation
    );
    controller = PhotoViewController()
      ..outputStateStream.listen(listener);
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value){
    setState((){
      scaleCopy = value.scale;
    });
  }

  String select(double scale, int index){
    // Selecting map image file by floor
    if (scale < 3.0){
      floor = 0;
      return maps[0];
    }else{
      return maps[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            // Map viewer
            child: PhotoView.customChild(
              initialScale: 2.5, // Initial scale of enlargement
              minScale: 1.0, // Lower boundary of scale of enlargement
              controller: controller,
              backgroundDecoration: BoxDecoration(
                color: Colors.white,),
              child: SvgPicture.asset(
                select(scaleCopy, floor),
                semanticsLabel: 'Map'
              ),
              )
          ),
          Positioned(
            // Floating search bar
            top: 30,
            right: 15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1.0),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PositionedTransition(
            // Floating button for tannoy notice
            rect: _animationController
                .drive(
                  CurveTween(
                    curve: Curves.elasticOut,
                  ),
                )
                .drive(
                  RelativeRectTween(
                    begin: RelativeRect.fromLTRB((size.width - 65), (size.height - 160), 20, 115),
                    end: RelativeRect.fromLTRB((size.width - 135), (size.height - 160), 90, 115),
                  ),
                ),
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.notifications,
                  color:Colors.black
                ),
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
                    begin: RelativeRect.fromLTRB((size.width - 65), (size.height - 160), 20, 115),
                    end: RelativeRect.fromLTRB((size.width - 125), (size.height - 220), 80, 175),
                  ),
                ),
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.bookmark,
                  color:Colors.black
                ),
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
                    begin: RelativeRect.fromLTRB((size.width - 65), (size.height - 160), 20, 115),
                    end: RelativeRect.fromLTRB((size.width - 65), (size.height - 230), 20, 185),
                  ),
                ),
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.settings,
                  color:Colors.black
                ),
                onPressed: () {
                  print("pressed");
                },
            ),
          ),
          Positioned(
            // Floating button to show other buttons
            bottom: 110,
            right: 15,
            child:FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.more_vert,
                color:Colors.black
              ),
              onPressed: () {
                if (_moved != true){
                  _animationController.forward();
                  _moved = true;
                }else{
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
            child:FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.location_on,
                color:Colors.black
              ),
              onPressed: () {
                print("pressed");
              },
            ),
          ),
          if (scaleCopy > 3.0)
            Positioned(
              // Picker to choose floor (It will show up when zoomed)
              top: 100,
              left: 15,
              child: Container(
                height: 150,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CupertinoPicker(
                  onSelectedItemChanged: (value) { floor = value;},
                  itemExtent: 30.0,
                  children: <Widget>[
                    Center(child: Text("T")),
                    Center(child: Text("3")),
                    Center(child: Text("2")),
                    Center(child: Text("1")),
                    Center(child: Text("G")),
                  ],
                )
              ),
            ),
          Positioned(
            // Sliding up pannel for time table
            child: SlidingUpPanel(
              panel: Center(
                child: Text("Time table"),
              ),
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    Text(
                      "\nExplore Your Timetable\n",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              topLeft: Radius.circular(24.0)
              ),
            ),
          ),
        ],
      ), 
    );
  }
}

