import 'package:baobab_app/models.dart';
import 'package:baobab_app/widgets/stories/mood.widget.dart';
import 'package:baobab_app/widgets/stories/story_date.widget.dart';
import 'package:baobab_app/widgets/stories/story_title.widget.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final Story storie;

  const Summary({Key key, this.storie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final data = BLoCProvider.of<StoryDetailBLoC>(context).data;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StoryDate(storyDate: storie.storyDate),
              StoryTitle(title: storie.title),
            ],
          ),
        ),
        Positioned(
          right: -32.0,
          child: Mood(size: 120.0),
        ),
      ],
    );
  }
}
