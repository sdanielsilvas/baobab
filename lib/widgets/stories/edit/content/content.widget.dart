import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/widgets/stories/edit/content/how_you_feel.widget.dart';
import 'package:baobab_app/widgets/stories/edit/content/how_your_day.widget.dart';
import 'package:baobab_app/widgets/stories/edit/content/story_date/story_date.widget.dart';
import 'package:baobab_app/widgets/stories/edit/content/what_made_today.widget.dart';
import 'package:baobab_app/widgets/stories/finishing.widget.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final _controller = PageController();
  final EditStoryBloc bloc;

  Content({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.scrollPage.listen((page) {
      if (_controller.hasClients) {
        _controller.animateToPage(
          page,
          duration: Duration(milliseconds: 1200),
          curve: Curves.ease,
        );
      }
    });
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        StoryDate(bloc: bloc),
        SelectMood(),
        HowYouFeel(),
        WhatMadeToday(bloc: bloc),
        //  Elaborate(),
        ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Finishing(bloc: this.bloc),
            )
          ],
        ),
      ],
    );
  }
}
