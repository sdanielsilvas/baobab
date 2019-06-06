import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/notes/note_list.dart';
import 'package:baobab_app/widgets/notes/quick_actions.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  final  String tittle;

  Intro({Key key, this.tittle}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 64.0, height: 64.0),
        AvenirText(
          tittle,
          style: Theme.of(context).textTheme.display1.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 36.0,
          ),
        ),
        SizedBox(width: 32.0, height: 32.0),
        _Divider(),
        SizedBox(width: 32.0, height: 32.0),
        Text(
          'TIPS',
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          '# Notas',
          style: Theme.of(context).textTheme.subhead,
        ),
        QuickActions(),
        //  NoteList()
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.0,
      height: 2.0,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(45.0),
      ),
    );
  }
}
