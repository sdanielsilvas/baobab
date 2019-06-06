import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/close.widget.dart';
import 'package:baobab_app/widgets/stories/edit/content/content.widget.dart';
import 'package:baobab_app/widgets/stories/edit/content/step_indicator.widget.dart';
import 'package:flutter/material.dart';

class EditStoryScreen extends StatelessWidget {

  final EditStoryBloc bloc ;

  EditStoryScreen({this.bloc});




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Background(),
          Content(bloc: this.bloc),
          SafeArea(child: AnimatedAvatar(bloc: this.bloc)),
          Close(onPressed: () => Navigator.pop(context)),
          StreamBuilder(
            initialData: 0,
            stream: bloc.scrollPage.stream,
            builder: (_, ss) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                right: ss.data == 0 || ss.data == 4 ? -64.0 : 0.0,
                bottom: 8.0,
                child: StepIndicator(bloc: this.bloc),
              );
            },
          )

        ],
      ),
    );
  }
}
