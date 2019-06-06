import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';


class StoryDate extends StatelessWidget {
  const StoryDate({
    Key key,
    @required this.storyDate,
  }) : super(key: key);

  final String storyDate;

  @override
  Widget build(BuildContext context) {
    return AvenirText(
      storyDate,
      style: Theme.of(context).textTheme.title.copyWith(
          color: Colors.black.withOpacity(0.9), fontWeight: FontWeight.bold),
    );
  }
}
