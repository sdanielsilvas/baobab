
import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/shadowed_box.widget.dart';
import 'package:flutter/material.dart';
import 'package:baobab_app/style/theme.dart' as Theme;

class NewHistoryStoryCard extends StatelessWidget {
  final Story story;

  NewHistoryStoryCard({this.story});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ShadowedBox(
        borderRadius: BorderRadius.circular(12.0),
        spreadRadius: -16.0,
        blurRadius: 24.0,
        shadowColor: Theme.Colors.loginGradientStart,
        shadowOffset: Offset(0.0, 24.0),
        margin: EdgeInsets.only(
          bottom: 106,
          left: 8.0,
          right: 8.0,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: <Widget>[
            _Background(),
            Drawable.newEntryBg,
            _Action(),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: NEW_STORY_CARD_TO_EDIT_STORY,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [Theme.Colors.splashSingleStart, Theme.Colors.splashSingleEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

///
class _Action extends StatelessWidget {
  const _Action({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Drawable.addNewStory,
          color: Colors.white,
          size: 100.0,
        ),
        SizedBox(width: 16.0, height: 16.0),
        AvenirText(
          'CREAR UNA NUEVA HISTORIA',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
