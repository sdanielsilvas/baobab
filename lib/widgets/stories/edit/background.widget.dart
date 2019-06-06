import 'package:baobab_app/style/theme.dart' as Theme;
import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'new_story_card_to_edit_story',
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.Colors.splashSingleEnd, Theme.Colors.splashSingleStart],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );

  }



}