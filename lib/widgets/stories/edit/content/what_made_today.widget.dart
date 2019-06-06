



import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/widgets/question.widget.dart';
import 'package:baobab_app/widgets/stories/edit/thing.widget.dart';
import 'package:flutter/material.dart';

class WhatMadeToday extends StatelessWidget {

  final EditStoryBloc bloc;
  const WhatMadeToday({Key key,this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final bloc = BLoCProvider.of<EditStoryBLoC>(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 100.0),
        StreamBuilder<double>(
          stream: bloc.howWasYourDay.stream,
          initialData: 5.0,
          builder: (_, ss) {
            String question = "Que te gustaría hacer hoy?";
            if (ss.data == 0.0) {
              question = kReallyTerrible;
            } else if (ss.data == 2.5) {
              question = kSomewhatBad;
            } else if (ss.data == 5.0) {
              question = kCompletelyOk;
            } else if (ss.data == 7.5) {
              question = kPrettyGood;
            } else if (ss.data == 10.0) {
              question = kSuperAwesome;
            }
            return Question(question);
          },
        ),
        Flexible(child: _ThingMadeToday(bloc: bloc)),
    SizedBox(width: 64.0, height: 64.0),
      ],
    );
  }
}

class _ThingMadeToday extends StatelessWidget {

  EditStoryBloc bloc;

  _ThingMadeToday({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        padding: EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 16.0,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.3,
        children: <Widget>[
          Thing(Drawable.work, title: "Trabajar",bloc: bloc),
          Thing(Drawable.family, title: "Compartir con la familia",bloc: bloc),
          Thing(Drawable.relationship, title: "Esta con mi pareja",bloc: bloc),
          Thing(Drawable.education, title: "Estudiar",bloc: bloc),
          Thing(Drawable.food, title: "Comer",bloc: bloc),
          Thing(Drawable.travelling, title: "Viajar",bloc: bloc),
          Thing(Drawable.friends, title: "Amigos",bloc: bloc),
          Thing(Drawable.exercise, title: "Ejercicio",bloc: bloc),
          Thing(Drawable.other, title: "Otro", color: Colors.black26,bloc: bloc),
        ],
      ),
    );
  }
}
