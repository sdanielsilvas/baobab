import 'package:flutter/material.dart';

class TimeLineViewImg extends StatelessWidget {
  final String planetName;
  final String imgAssetPath;

  TimeLineViewImg( {this.imgAssetPath,this.planetName});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: '$planetName',
      flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation,
          HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
        if (flightDirection == HeroFlightDirection.pop) {
          return Container();
        } else if (flightDirection == HeroFlightDirection.push) {
          return toHeroContext.widget;
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 0.0),
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          imgAssetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
