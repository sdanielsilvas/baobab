

import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;

  const Question(this.question, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: QuicksandText(
            question,
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
