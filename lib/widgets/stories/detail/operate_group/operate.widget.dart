import 'package:flutter/material.dart';

class Operate extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final EdgeInsets margin;
  final int quarterTurns;

  const Operate({
    Key key,
    @required this.iconData,
    @required this.onTap,
    @required this.margin,
    this.quarterTurns = 0,
  }) : super(key: key);

  factory Operate.forDesignTime() {
    return Operate(
      iconData: Icons.add,
      onTap: () {},
      margin: EdgeInsets.all(8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: margin,
        elevation: 16.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: RotatedBox(quarterTurns: quarterTurns, child: Icon(iconData)),
        ),
      ),
    );
  }
}
