


import 'package:baobab_app/animation/show_up.transition.dart';
import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedAvatar extends StatelessWidget {
  final EditStoryBloc bloc;
  const AnimatedAvatar({Key key,this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = BLoCProvider.of<EditStoryBLoC>(context);
    return StreamBuilder(
      stream: bloc.scrollPage.stream,
      initialData: 0,
      builder: (_, ss) {

        final isCPosition = ss.data == 0 || ss.data == 5;
        return AnimatedContainer(
          duration: Duration(milliseconds: 1200),
          curve: Curves.ease,
          margin: EdgeInsets.only(
            top: isCPosition ? 64.0 : 32.0,
            left: isCPosition ? 0.0 : 32.0,
          ),
          alignment: isCPosition
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.topStart,
          transform: Matrix4.identity()..scale(isCPosition ? 1.0 : 0.7),
          child: ShowUpTransition(child: Avatar(width: 80.0, height: 80.0)),
        );
      },
    );
  }
}
