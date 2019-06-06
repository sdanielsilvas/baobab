import 'package:baobab_app/blocs/local/story_home.bloc.dart';
import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/blocs/stories/stories_state.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/stories/back_to_index.widget.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'story_view.dart';

class StoriesWidget extends StatefulWidget {
  final TimeLineApp timeLineApp;

  StoriesWidget({Key key, this.timeLineApp}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _StoriesWidgetState();
  }
}

class _StoriesWidgetState extends State<StoriesWidget> {
  List<Story> data = stories;
  StoriesBloc storiesBloc;

  @override
  void initState() {
    // TODO: implement initState
    storiesBloc = BlocProvider.of<StoriesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    StoryHomeBLoC homeBloc = StoryHomeBLoC();

    return BlocBuilder(
        bloc: storiesBloc,
        builder: (BuildContext context, StoriesState storiesState) {
          print("storie");
          if (storiesState.isInitialising) {
            storiesBloc.loadEvents();
            return Container();
          } else if (storiesState.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (storiesState.stories != null) {
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    DecoratedColumn(
                      color: Colors.white,
                      children: <Widget>[
                        SizedBox(width: 8.0, height: 8.0),
                        SafeArea(child: Avatar(width: 48.0, height: 48.0)),
                        SizedBox(width: 32.0, height: 32.0),
                        Flexible(
                            child: StoryPageView(
                              timeLineApp: widget.timeLineApp,
                          storyList: storiesState.stories,
                          storyHomebloc: homeBloc,
                        )),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: BackToIndex(bloc: homeBloc),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _loadingIndicator() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
