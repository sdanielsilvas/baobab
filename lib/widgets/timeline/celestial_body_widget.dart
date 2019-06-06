import 'package:flutter/material.dart';

class CelestialBodyWidget extends StatelessWidget {
  final String imagePath;

  CelestialBodyWidget({this.imagePath});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.transparent,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.transparent,
            Colors.transparent,
            Colors.transparent.withOpacity(0.65),
            Colors.transparent,
            Colors.black
          ],
        ),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
       // color: Color.fromRGBO(255, 0, 0, 1),
        //  colorBlendMode: BlendMode.modulate
      ),
    );
  }
}
