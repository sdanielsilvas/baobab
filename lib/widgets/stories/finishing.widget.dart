import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/widgets/bi_opeate.widget.dart';
import 'package:baobab_app/widgets/question.widget.dart';
import 'package:baobab_app/widgets/stories/edit/content/how_your_day.widget.dart';
import 'package:flutter/material.dart';

const kPositiveLabel = 'Obtener la meditacion del dia';
const kNegativeLabel = 'Espera he olvidado algo!';
const kAddTitle = 'Titulo...';

const kInputContentPadding = EdgeInsets.symmetric(
  horizontal: 16.0,
  vertical: 4.0,
);

class Finishing extends StatefulWidget {
  final EditStoryBloc bloc;

  Finishing({this.bloc});
  @override
  _FinishingState createState() {
    return _FinishingState();
  }
}

class _FinishingState extends State<Finishing> {
  int _textCount = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(height: 96.0),
        Question(kQuestion),
        TextField(
          onChanged: (text) {
            setState(() => _textCount = text.length);
          },
          cursorColor: Colors.white70,
          cursorWidth: 1.0,
          style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white70),
          decoration: InputDecoration(
            counterText: '$_textCount / 40',
            helperText: 'Titulo de tu día',
            helperStyle: Theme.of(context).textTheme.caption.copyWith(color: Colors.white30),
            contentPadding: kInputContentPadding,
            border: InputBorder.none,
            hintText: kAddTitle,
            hintStyle: Theme.of(context).textTheme.headline.copyWith(color: Colors.white70, fontFamily: 'Avenir'),
          ),
        ),
        BiOperate(
          positiveLabel: kPositiveLabel,
          negativeLabel: kNegativeLabel,
          onPositivePressed: () {},
          onNegativePressed: () {
            print("get");
             widget.bloc.scrollPage.add(widget.bloc.scrollPage.latest - 1);
          },
        ),
      ],
    );
  }
}
