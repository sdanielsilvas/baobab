

import 'package:baobab_app/animation/fade_slide.transition.dart';
import 'package:baobab_app/animation/show_up.transition.dart';
import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/utils/times.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/stories/edit/content/story_date/select_date.widget.dart';
import 'package:flutter/material.dart';

class StoryDate extends StatelessWidget {
  const StoryDate({Key key,@required this.bloc}) : super(key: key);
  final EditStoryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(width: 80.0, height: 80.0),
        _Greeting(),
        SelectDate(),
        _LetsDoIt(bloc: bloc),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: FadeSlideTransition(
        delay: Duration(milliseconds: 300),
        builder: (context, controller) {
          return QuicksandText(//${Times.currentPeriod()}
          'Buenas! ${Times.currentPeriod()}, hola, Estas listo para crear una nueva historia?',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.white70),
          );
        },
      ),
    );
  }
}

class _LetsDoIt extends StatelessWidget {
  _LetsDoIt({this.bloc});
  final EditStoryBloc bloc;
  factory _LetsDoIt.forDesignTime() => _LetsDoIt();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return ShowUpTransition(
      delay: 1300,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: RaisedButton(
          elevation: 8.0,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          onPressed: () {
            bloc.scrollPage.add(1);
          },
          shape: StadiumBorder(),
          color: Colors.white,
          child: Text(
            'Vamos a Hacerlo Juntos!',
            style: theme.textTheme.subhead.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
