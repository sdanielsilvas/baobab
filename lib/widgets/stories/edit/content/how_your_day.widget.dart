import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/widgets/fonted_text.dart';
import 'package:baobab_app/widgets/question.widget.dart';
import 'package:flutter/material.dart';

const kQuestion = 'Cómo fue tu día Hoy?';
const kRateYourDay = 'Valora tu día';

class SelectMood extends StatelessWidget {

  final EditStoryBloc bloc;
  const SelectMood({Key key,this.bloc}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 100.0),
        Question(kQuestion),
        Flexible(child: _RateYourToday(bloc: bloc)),
      ],
    );
  }
}

class _RateYourToday extends StatefulWidget {
  final EditStoryBloc bloc;

  _RateYourToday({this.bloc});
  @override
  _RateYourTodayState createState() {
    return _RateYourTodayState();
  }
}

class _RateYourTodayState extends State<_RateYourToday> {
  double _sliderValue = 5.0;
  IconData _iconData = Drawable.completelyOk;
  String _moodDesc = kCompletelyOk;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          _iconData,
          size: 100.0,
          color: Colors.white,
        ),
        SizedBox(width: 16.0, height: 16.0),
        Slider(
          min: 0.0,
          max: 10.0,
          divisions: 4,
          value: _sliderValue,
          onChanged: _onSliderChange,
          onChangeEnd: _onSliderChangeEnd,
        ),
        SizedBox(width: 16.0, height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AvenirText(
                kRateYourDay,
                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
              ),
              AvenirText(
                _moodDesc,
                style: Theme.of(context).textTheme.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(width: 64, height: 64),
      ],
    );
  }

  void _onSliderChange(double value) {
    setState(() {
      _sliderValue = value;
      if (value == 0.0) {
        _iconData = Drawable.reallyTerrible;
        _moodDesc = krReallyTerrible;
      } else if (value == 2.5) {
        _iconData = Drawable.somewhatBad;
        _moodDesc = kSomewhatBad;
      } else if (value == 5.0) {
        _iconData = Drawable.completelyOk;
        _moodDesc = kCompletelyOk;
      } else if (value == 7.5) {
        _iconData = Drawable.prettyGood;
        _moodDesc = kPrettyGood;
      } else if (value == 10.0) {
        _iconData = Drawable.superAwesome;
        _moodDesc = kSuperAwesome;
      }
    });
  }

  void _onSliderChangeEnd(double value) {

    widget.bloc.howWasYourDay.add(value);
    widget.bloc..scrollPage.add(2);
  }
}
