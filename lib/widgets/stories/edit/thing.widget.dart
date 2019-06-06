import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/shadowed_box.widget.dart';
import 'package:flutter/material.dart';

class Thing extends StatelessWidget {
  final IconData iconData;
  final String title;
  final EditStoryBloc bloc;

  final Color color;

  const Thing(this.iconData, {Key key, @required this.title, this.color = Colors.white, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (detail) => bloc.whatMadeToday.add(title),
      child: StreamBuilder<String>(
        stream: bloc.whatMadeToday.stream,
        builder: (_, ss) {
          final selected = ss.data == title;
          return selected
              ? ShadowedBox(
                  borderRadius: BorderRadius.circular(8.0),
                  spreadRadius: -8.0,
                  child: _Content(
                    iconData: iconData,
                    selected: selected,
                    color: color,
                    title: title,
                  ),
                )
              : _Content(
                  iconData: iconData,
                  selected: selected,
                  color: color,
                  title: title,
                );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key key,
    @required this.iconData,
    @required this.selected,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  final IconData iconData;
  final bool selected;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          color: selected ? primaryColor : color,
          size: 32.0,
        ),
        SizedBox(width: 8.0, height: 8.0),
        AvenirText(
          title,
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: selected ? primaryColor : Colors.white.withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}
