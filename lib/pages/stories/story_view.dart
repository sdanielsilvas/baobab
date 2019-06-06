import 'package:baobab_app/blocs/local/story_home.bloc.dart';
import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/stories/intro.widget.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/stories/history_story_card.widget.dart';
import 'package:flutter/material.dart';

class StoryPageView extends StatefulWidget {
  final List<Story> storyList;
 // final StoriesBloc storiesBloc;
  final StoryHomeBLoC storyHomebloc;

  TimeLineApp timeLineApp;

  StoryPageView({this.storyList,  this.storyHomebloc,this.timeLineApp});

  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryPageView> {
  final _controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    widget.storyHomebloc.pageChange.where((pageChange) => pageChange.triggeredByBack).listen((pageChange) {
      _controller.animateToPage(
        pageChange.page,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });

    return SafeArea(
      child: _buildPager(widget.storyHomebloc),
    );
  }

  Widget _buildPager(StoryHomeBLoC bloc) {
    //print(stories.length);
  //var itme = widget.timeLineApp.achievements[1];

    return PageView.builder(
      controller: _controller,
      onPageChanged: (page) => bloc.pageChange.add(PageChange(page)),
      itemCount: widget.timeLineApp.achievements.length+1 ,
      itemBuilder: (context, index) {
        print("item" + index.toString());
        if (index == 0) return Intro(tittle: widget.timeLineApp.name);
        return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double factor = 1.0;
              if (_controller.position.haveDimensions) {
                factor = _controller.page - index;
                factor = (1 - (factor.abs() * .2)).clamp(0.8, 1.0);
              }
              return Transform.scale(
                scale: Curves.easeOut.transform(factor),
                child: child,
              );
            },
              child: HistoryStoryCard(achievements: widget.timeLineApp.achievements[index-1]),
             //child: HistoryStoryCard(achievements: index==1? widget.timeLineApp.achievements[index-1]:widget.timeLineApp.achievements[index-2]),

            /*child: index == 1
                ? new NewHistoryStoryCard()
                : HistoryStoryCard(
                    story: widget.storyList.length > 2 ? widget.storyList[index - 2] : widget.storyList[index - 2],
                    )*/
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
