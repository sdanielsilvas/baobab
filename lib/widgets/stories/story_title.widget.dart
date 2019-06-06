import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';


///
/// story标题
///
class StoryTitle extends StatelessWidget {
  const StoryTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return QuicksandText(
      title,
      style: Theme.of(context).textTheme.display1.copyWith(
        color: Colors.white.withOpacity(0.8),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
