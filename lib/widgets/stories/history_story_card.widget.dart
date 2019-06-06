import 'dart:ui';

import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/story_detail/story_detail.screen.dart';
import 'package:baobab_app/routes.dart';
import 'package:baobab_app/widgets/shadowed_box.widget.dart';
import 'package:baobab_app/widgets/stories/image.widget.dart';
import 'package:baobab_app/widgets/stories/mood.widget.dart';
import 'package:baobab_app/widgets/stories/story_date.widget.dart';
import 'package:baobab_app/widgets/stories/story_title.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryStoryCard extends StatelessWidget {
  final Achievement achievements;
  AnimationController _onNavigationAnimController;

  HistoryStoryCard({
    @required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    //_swipeAnimController = AnimationController(duration: Duration(milliseconds: 600), vsync: this)
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        //StoryDetailScreen
        //Navigator.pushNamed(context, '/story_detail');
        // _onNavigationAnimController.forward();
        Navigator.of(context)
            .push(
          HomePageRoute(
            transDuation: Duration(milliseconds: 600),
            builder: (BuildContext context) {
              return StoryDetailScreen(achievements: achievements);
            },
          ),
        )
            .then((_) {
          //_onNavigationAnimController.reverse();
        });
      },
      child: ShadowedBox(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        spreadRadius: -16.0,
        blurRadius: 24.0,
        shadowOffset: Offset(0.0, 24.0),
        margin: EdgeInsets.only(
          bottom: 106,
          left: 8.0,
          right: 8.0,
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              left: 2.0,
              top: 20.0,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.transparent.withOpacity(0.5),
                            BlendMode.color),
                        image: NetworkImage(achievements.img),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),

            Padding(
               padding: EdgeInsets.only(top: 310),
              child: new SingleChildScrollView(
                  child: Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                child: Text(
                  achievements.description,
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              )),
            ),

            Positioned(
              left: 24.0,
              top: 0,
              child: StoryDate(storyDate: achievements.name),
            ),
            /*Positioned(
              right: 24.0,
              top: 24.0,
              child: _Favorite(),
            ),*/
            /*Positioned(
              left: 24.0,
              bottom: 24.0,
              child: StoryTitle(title: achievements.name),
            ),
            Positioned(
              right: -16.0,
              bottom: 24.0,
              child: Mood(),
            ),*/
          ],
        ),
      ),
    );
  }
}

class _Favorite extends StatelessWidget {
  const _Favorite({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border, color: Colors.white),
      onPressed: () {},
    );
  }
}
