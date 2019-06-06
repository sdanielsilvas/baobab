import 'package:baobab_app/blocs/notes/notes_bloc.dart';
import 'package:baobab_app/models/notes.dart';
import 'package:baobab_app/utils/color_utility.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class QuickActions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActions> {
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    updateListView();
    final blueGradient = const LinearGradient(colors: const <Color>[
      const Color(0xFF0075D1),
      const Color(0xFF00A2E3),
    ], stops: const <double>[
      0.4,
      0.6
    ], begin: Alignment.topRight, end: Alignment.bottomLeft);
    final purpleGraient = const LinearGradient(
        //colors: const <Color>[const Color(0xFFFFFFFF), const Color(0xFFFFFFFF)],
        colors: const <Color>[const Color(0xFFFFFFFF), const Color(0xFFFFFFFF)],
        stops: const <double>[0.5, 0.7],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
    final redGradient = const LinearGradient(colors: const <Color>[
      const Color(0xFFBA110E),
      const Color(0xFFCF3110),
    ], stops: const <double>[
      0.6,
      0.8
    ], begin: Alignment.bottomRight, end: Alignment.topLeft);
    return new Container(
      constraints: const BoxConstraints(maxHeight: 190.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: new Align(
        alignment: Alignment.center,
        child: ListView.builder(
            padding: const EdgeInsets.only(
                left: 10.0, bottom: 20.0, right: 10.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: count,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => _buildAction(
                index,
                () {},
                Colors.transparent,
                purpleGraient,
                new AssetImage("assets/images/wallet.png"))),
        /*child: new ListView(

            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 10.0, bottom: 20.0, right: 10.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildAction(
                  "Live\nBroadcast", () {}, Colors.lightBlueAccent, blueGradient,
                  new AssetImage("assets/images/microphone.png")),
              _buildAction(
                  "My\nWallet", () {}, Colors.cyan, purpleGraient,
                  new AssetImage("assets/images/wallet.png")),
              _buildAction(
                  "Game\nCenter", () {}, Colors.black26, redGradient,
                  new AssetImage("assets/images/joystick.png")),
            ]
        ),*/
      ),
    );
  }
  void updateListView() {
    this.noteList = noteList;

    NotesBloc notesBloc = new NotesBloc();

    notesBloc.streamPlayList.listen((item){
      setState(() {
        this.noteList = item;
        this.count = item.length;
      });
    });



  }



  Widget _buildAction(int index, VoidCallback action, Color color,
      Gradient gradient, ImageProvider backgroundImage) {
    final textStyle = new TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18.0);

    return new GestureDetector(
      onTap: action,
      child: new Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        width: 150.0,
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.white,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: new Offset(0.0, 1.0)),
            ],
            gradient: gradient),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.transparent),
              borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        this.noteList[index].title,
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Text(
                    getPriorityText(this.noteList[index].priority),
                    style: TextStyle(
                        color: getPriorityColor(
                            this.noteList[index].priority)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          this.noteList[index].description == null
                              ? ''
                              : this.noteList[index].description,
                          style: TextStyle(
                              fontFamily: 'Sans',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 10)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }

  // Returns the priority icon
  String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
        break;
      case 2:
        return '!!';
        break;
      case 3:
        return '!';
        break;

      default:
        return '!!!';
    }
  }
}

class _BackgroundImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
