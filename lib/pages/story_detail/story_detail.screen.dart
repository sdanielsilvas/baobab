import 'dart:io';

import 'package:baobab_app/blocs/local/story_detail.bloc.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/stories/detail/operate_group/operate_gourp.widget.dart';
import 'package:baobab_app/widgets/stories/detail/summary.widget.dart';
import 'package:baobab_app/widgets/stories/image.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryDetailScreen extends StatefulWidget {
  final Achievement achievements;

  StoryDetailScreen({@required this.achievements});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _StoryDetailScreenState();
  }
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final _controller = ScrollController();
  final StoryDetailBLoC bloc = new StoryDetailBLoC();
  double _parallaxOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() => _parallaxOffset = -_controller.offset * 0.2);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    

    
    

    return WillPopScope(
      onWillPop: () async => !Platform.isIOS,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //Text("Hola Mundo"),



            /*Hero(
              tag: widget.achievements.name,
              child: Transform.translate(
                offset: Offset(0.0, _parallaxOffset),
                child: SizedBox.expand(
                  child: ImageWidget(imageUrl: widget.achievements.img),
                ),
              ),
            ),*/
           /* Hero(
              tag: widget.achievements.id,
              child: Transform.translate(
                offset: Offset(0.0, _parallaxOffset),
                child: SizedBox.expand(
                  child: ImageWidget(imageUrl: widget.achievements.img),
                ),
              ),
            ),*/

           /* ListView(
              controller: _controller,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.65),
                SizedBox(
                  height: screenHeight * 0.18,
                  child: Summary(storie: widget.story),
                ),
                SizedBox(width: 16.0, height: 16.0),
                ContentDetail(idStory: widget.story.id),
              ],
            ),*/
              Padding(padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: ContentDetail(idStory: widget.achievements.id) ,
              ),

              OperateGroup(bloc: bloc),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
