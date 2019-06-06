import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/widgets/shadowed_box.widget.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double width;
  final double height;

  const Avatar({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Hero(
        tag: 'splash',
        child: CircleAvatar(
          backgroundImage: AssetImage(Drawable.logoGif),
        ),
      ),
    );

    return ShadowedBox(
      //shape: BoxShape.circle,
      width: width,
      height: height,
      // shadowColor: Colors.transparent,
      //shadowOffset: Offset(0.0, 12.0),
      spreadRadius: -12.0,
      blurRadius: 24.0,
      child: CircleAvatar(
        backgroundImage: AssetImage(Drawable.logoGif),
      ),
    );
  }
}
