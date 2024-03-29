

import 'package:baobab_app/animation/fade_slide.transition.dart';
import 'package:baobab_app/utils/times.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/calendar.widget.dart';
import 'package:flutter/material.dart';

class SelectDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        FadeSlideTransition(
          delay: Duration(milliseconds: 600),
          builder: (context, controller) => _Background(),
        ),
        FadeSlideTransition(
          delay: Duration(milliseconds: 700),
          builder: (context, controller) => _DateSelector(),
        ),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCalendar(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AvenirText(
                Times.currentNamedMonthDay(),
                style: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0, height: 8.0),
              Text(
                Times.relativeDate(DateTime.now()),
                style: Theme.of(context).textTheme.body1.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Icon(Icons.keyboard_arrow_down, color: Colors.white30),
          ),
        ],
      ),
    );
  }

  _showCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Calendar(),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      heightFactor: 2.0,
      child: QuicksandText(
        'Mi Historia',
        style: Theme.of(context).textTheme.display3.copyWith(
          color: Color(0XFF7775C5),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
