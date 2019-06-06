import 'dart:async';

import 'package:flutter/material.dart';

class ConnectivityOverlay extends StatefulWidget {
  final Widget child;
  final Completer<void> connectedCompleter;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ConnectivityOverlay({this.child, this.connectedCompleter, this.scaffoldKey});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ConnectivityOverlayState();
  }
}

class _ConnectivityOverlayState extends State<ConnectivityOverlay>{

//  StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool connected = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}


