import 'package:flutter/material.dart';
import 'package:baobab_app/helper/helper.export.dart';

class Mood extends StatelessWidget {
  final double size;

  const Mood({
    Key key,
    this.size = 96.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Drawable.happy,
      color: Colors.white.withOpacity(0.5),
      size: size,
    );
  }
}
