import 'package:flutter/material.dart';

// directions view
class SummaryView extends StatefulWidget{
  @override
  SummaryViewState createState() => SummaryViewState();
}

class SummaryViewState extends State<SummaryView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(), // TODO: replace with custom appbar
      body: Stack(
        children: <Widget>[
          Image.asset('assets/map.png', // TODO:  replace temporary image
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,),
          
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
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 20, 0, 20), 
                      child: Text(getDestination(), style: TextStyle(fontSize: 30))
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.directions_walk, size: 80,),
                        IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(getSummary(), style: TextStyle(fontSize: 18),),
                              RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                onPressed: () {Navigator.of(context).pushNamed('/direct');},
                                child: const Text('Start Navigation', style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: () {Navigator.of(context).maybePop();}, // TODO: navigation
                        child: Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 15))
                      )
                    )
                  ],
                ),
              )
            ),
          ),
        ],
      )
    );
  }

  String getDestination(){ // TODO: replace
    return "Room 005";
  }

  String getSummary(){ // TODO: replace
    return "120 metres / 1 minute";
  }
}