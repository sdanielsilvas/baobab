import 'package:baobab_app/animation/fade_slide.transition.dart';
import 'package:baobab_app/blocs/playlist/playlist_bloc.dart';
import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:baobab_app/widgets/music/play_list.widget.dart';
import 'package:baobab_app/widgets/shadowed_box.widget.dart';
import 'package:flutter/material.dart';

import '../../fonted_text.dart';

class ContentDetail extends StatefulWidget {
  final String idStory;

  ContentDetail({this.idStory});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ContentDetailState();
  }
}

class _ContentDetailState extends State<ContentDetail> {
  static const SPACE_BIG = SizedBox(width: 16.0, height: 16.0);
  static const SPACE_HUGE = SizedBox(width: 32.0, height: 32.0);
  static const SPACE_GIANT = SizedBox(width: 64.0, height: 64.0);
  static const kSpaceHuge = 32.0;
  static const kSpaceZero = 0.0;
  static const kSpaceLarge = 24.0;

  StoriesBloc storiesBloc;

  @override
  void initState() {
    // TODO: implement initState
    storiesBloc = StoriesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    final titleTheme =
    Theme
        .of(context)
        .textTheme
        .body1
        .copyWith(fontWeight: FontWeight.bold);
    final contentTheme =
    Theme
        .of(context)
        .textTheme
        .subhead
        .copyWith(color: Colors.grey);

    PlayListBloc playListBloc = PlayListBloc();

    playListBloc.playListFilter.add("1");

    // StoriesBloc storiesBloc = BlocProvider.of<StoriesBloc>(context);;

    return FadeSlideTransition(
        originOffset: Offset(0.0, 200.0),
        delay: Duration(microseconds: 600),
        builder: (_, __) {
          return ShadowedBox(
            spreadRadius: -8.0,
            borderRadius: BorderRadius.circular(24.0),
            margin: EdgeInsets.all(kSpaceZero),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceLarge,
                vertical: kSpaceLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                // _VisualHandle(),
                SPACE_GIANT,
                AvenirText('Tus Meditaciondes', style: titleTheme),
                SPACE_BIG,
                 StreamBuilder<List<PlayList>>(
                  stream: playListBloc.streamPlayList,
                  builder: (BuildContext context, AsyncSnapshot snap) {

                    // return Container();

                      if(snap.data!=null){
                       return  PlayListWidget(playlist: snap.data);
                        //return Container();
                      }else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      }



                  },

                ),

                // PlayList(songs: storiesState.songs),
                SPACE_HUGE,
                /* AvenirText('Cómo te sientes Hoy?', style: titleTheme),
                        SPACE_BIG,
                        AvenirText('Me siento Feliz', style: contentTheme),
                        SPACE_GIANT,
                        AvenirText('Que desearias esta haciendo ? ', style: titleTheme),
                        SPACE_BIG,
                        AvenirText('Viajando', style: contentTheme),
                        SPACE_GIANT,

                        AvenirText('Conciencia plena de la existencia: 3205 , nubes con un rayo de luz', style: contentTheme),
                        SPACE_GIANT,
                        AvenirText('Imagen del día', style: titleTheme),
                        SPACE_BIG,*/
                // _AddImage(),
                SPACE_HUGE,
                ],
              ),
            ),
          );
        });
    /* } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },*/
    //  );
  }
}

class _VisualHandle extends StatelessWidget {
  const _VisualHandle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      heightFactor: 4.0,
      child: Container(
        height: 6.0,
        width: 64.0,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(45.0),
        ),
      ),
    );
  }
}
