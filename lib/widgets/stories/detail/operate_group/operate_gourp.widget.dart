import 'package:baobab_app/animation/fade_slide.transition.dart';
import 'package:baobab_app/blocs/local/story_detail.bloc.dart';
import 'package:baobab_app/blocs/local/edit_story.bloc.dart';
import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/pages/edit_story/edit_story.screen.dart';
import 'package:baobab_app/routes.dart';
import 'package:baobab_app/widgets/stories/detail/operate_group/operate.widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OperateGroup extends StatelessWidget {
  final StoryDetailBLoC bloc;

  const OperateGroup({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Exit(),
          Column(
            children: <Widget>[
              //_More(bloc: bloc),
              _Edit(bloc: bloc),
              //_UploadPicture(bloc: bloc),
              // _Delete(bloc: bloc),
            ],
          ),
        ],
      ),
    );
  }
}

/// 退出
class _Exit extends StatelessWidget {
  const _Exit({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      direction: SlideDirection.horizontal,
      originOffset: Offset(-100.0, 0.0),
      builder: (_, __) {
        return Operate(
          iconData: Drawable.back1,
          onTap: () => Navigator.pop(context),
          margin: EdgeInsets.only(left: 16.0, top: 16.0),
          quarterTurns: 0,
        );
      },
    );
  }
}

class _More extends StatelessWidget {
  final StoryDetailBLoC bloc;

  const _More({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      direction: SlideDirection.horizontal,
      originOffset: Offset(100.0, 0.0),
      builder: (_, __) {
        return StreamBuilder<bool>(
          stream: bloc.showMoreOperate.stream,
          initialData: false,
          builder: (_, ss) {
            return Operate(
              iconData: ss.data ? Drawable.closeBold : Drawable.moreBold,
              onTap: () {
                print('nmore');
                bloc.showMoreOperate.add(!bloc.showMoreOperate.latest);
              },
              margin: EdgeInsets.only(
                right: 16.0,
                top: 16.0,
              ),
              quarterTurns: 1,
            );
          },
        );
      },
    );
  }
}

/// 编辑
class _Edit extends StatelessWidget {
  final StoryDetailBLoC bloc;

  const _Edit({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      direction: SlideDirection.horizontal,
      immediately: false,
      originOffset: Offset(100.0, 0.0),
      builder: (_, controller) {
        final EditStoryBloc blocEdit = EditStoryBloc();
        return StreamBuilder<bool>(
          stream: bloc.showMoreOperate.stream,
          initialData: false,
          builder: (_, ss) {
            ss.data ? controller.forward() : controller.reverse();
            return Operate(
              iconData: Drawable.write,
              //onTap: () => Navigator.push(context, RoutePath.edit_story),

              onTap: () {
                Navigator.push(
                    context,
                    HomePageRoute(
                        transDuation: Duration(milliseconds: 600),
                        builder: (BuildContext context) {
                          return EditStoryScreen(bloc: blocEdit);
                        }));
              },
              margin: EdgeInsets.only(
                right: 16.0,
                top: 16.0,
              ),
            );
          },
        );
      },
    );
  }
}

/// 上传照片
class _UploadPicture extends StatelessWidget {
  final StoryDetailBLoC bloc;

  const _UploadPicture({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final bloc = BLoCProvider.of<StoryDetailBLoC>(context);
    return FadeSlideTransition(
      direction: SlideDirection.horizontal,
      immediately: false,
      originOffset: Offset(100.0, 0.0),
      builder: (_, controller) {
        return StreamBuilder<bool>(
          stream: bloc.showMoreOperate.stream,
          initialData: false,
          builder: (_, ss) {
            Observable.timer(null, Duration(milliseconds: 200)).listen(
                (_) => ss.data ? controller.forward() : controller.reverse());
            return Operate(
              iconData: Drawable.editImage,
              onTap: () {
                /*     bloc.showMoreOperate.add(!bloc.showMoreOperate.latest);
                showLightDialog(
                  context: context,
                  builder: (context) {
                    return UpdateCover(storyImage: bloc.data.storyImage);
                  },
                );*/
              },
              margin: EdgeInsets.only(
                right: 16.0,
                top: 16.0,
              ),
            );
          },
        );
      },
    );
  }
}

/// 删除
class _Delete extends StatelessWidget {
  final StoryDetailBLoC bloc;

  const _Delete({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      direction: SlideDirection.horizontal,
      immediately: false,
      originOffset: Offset(100.0, 0.0),
      builder: (_, controller) {
        return StreamBuilder<bool>(
          stream: bloc.showMoreOperate.stream,
          initialData: false,
          builder: (_, ss) {
            Observable.timer(null, Duration(milliseconds: 400)).listen(
                (_) => ss.data ? controller.forward() : controller.reverse());
            return Operate(
              iconData: Drawable.deleteBold,
              onTap: () {},
              margin: EdgeInsets.only(
                right: 16.0,
                top: 16.0,
              ),
            );
          },
        );
      },
    );
  }
}
