import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'check_animation.dart';

class LastPage extends StatefulWidget {
  final String statusType;

  LastPage({this.statusType});

  @override
  State<StatefulWidget> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    return Scaffold(
      body: Center(
        child:
            Container(padding: EdgeInsets.all(16.0), child: getPages(_width)),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
        height: 50.0,
        child: Center(
            child: Text(
          'Comenzar',
          style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
        )),
      )),
    );
  }

  Widget getPages(double _width) {
    return Container(
      child: Opacity(
        opacity: 1,
        //opacity: controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Center(
                    child: new Image(
                        width: 250.0,
                        height: 191.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/img/login_logo.png')))),
            CheckAnimation(),
            Text(
              'Tu centra esta Activa!.',
              style: TextStyle(
                  color: Color(0xFF2b7cb6),
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
              child: Text(
                'Bienvenido.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
