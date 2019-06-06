

import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:flutter/material.dart';

const kIndicatorSize = 32.0;

class StepIndicator extends StatelessWidget {
  final EditStoryBloc bloc;
  const StepIndicator({Key key,this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_arrow_up, size: kIndicatorSize),
                color: Colors.white.withOpacity(0.4),
                onPressed: () =>
                    bloc.scrollPage.add(bloc.scrollPage.latest - 1),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_down, size: kIndicatorSize),
                color: Colors.white,
                onPressed: () =>
                    bloc.scrollPage.add(bloc.scrollPage.latest + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
