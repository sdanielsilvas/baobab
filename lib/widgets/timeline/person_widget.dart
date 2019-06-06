import 'dart:async';

import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/stories/stories_page.dart';
import 'package:baobab_app/pages/timeline/time_line_page.dart';
import 'package:baobab_app/pages/timeline/time_line_view_page.dart';
import 'package:baobab_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'time_line_view_img.dart';

class PersonWidget extends StatefulWidget {
  final Size size;
  final List<TimeLineApp> timeLines;
  final int currentPlanetIndex;
  final Stream shouldNavigate;

  PersonWidget(
      {@required this.size,
      this.timeLines,
      this.currentPlanetIndex,
      this.shouldNavigate});

  @override
  _PersonWidgetState createState() {
    return new _PersonWidgetState();
  }
}

class _PersonWidgetState extends State<PersonWidget>
    with TickerProviderStateMixin {
  AnimationController _smokeAnimController;
  AnimationController _scaleAnimController;
  AnimationController _floatingAnimController;
  Animation<Offset> _floatingAnim;
  TabController _tabController;
  StreamSubscription _navigationSubscription;

  @override
  void initState() {
    super.initState();
    _smokeAnimController =
        AnimationController(duration: Duration(seconds: 35), vsync: this);

    _floatingAnimController = AnimationController(
        duration: Duration(milliseconds: 1700), vsync: this);

    _floatingAnim = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.025))
        .animate(_floatingAnimController);

    _smokeAnimController.repeat();

    _floatingAnimController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _floatingAnimController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _floatingAnimController.forward();
      }
    });

    _floatingAnimController.forward();

    _tabController = TabController(
        initialIndex: widget.currentPlanetIndex,
        length: widget.timeLines.length,
        vsync: this);
    print("click time before");
    _navigationSubscription = widget.shouldNavigate.listen((_) async {
      if (widget.timeLines[widget.currentPlanetIndex].achievements.length > 0) {
        StoriesBloc storiesBloc = StoriesBloc();

        Navigator.of(context)
            .push(
          HomePageRoute(
            transDuation: Duration(milliseconds: 600),
            builder: (BuildContext context) {
              return BlocProvider(
                bloc: storiesBloc,
                child: StoriesWidget(
                    timeLineApp: widget.timeLines[widget.currentPlanetIndex]),
              );
            },
          ),
        )
            .then((_) {
          _scaleAnimController.reverse();
        });

        await _scaleAnimController.forward();
      }
    });

    _scaleAnimController = AnimationController(
        lowerBound: 1.0,
        upperBound: 7.0,
        duration: Duration(milliseconds: 700),
        vsync: this);
  }

  @override
  void didUpdateWidget(PersonWidget oldWidget) {
    if (widget.currentPlanetIndex != oldWidget.currentPlanetIndex) {
      _tabController.animateTo(widget.currentPlanetIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _smokeAnimController.dispose();
    _floatingAnimController.dispose();
    _tabController.dispose();
    _navigationSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print("Time lines");
    //print(widget.timeLines.length);
    final double size = widget.size.width * 0.60;
    return SlideTransition(
      position: _floatingAnim,
      child: ScaleTransition(
        scale: _scaleAnimController,
        child: Container(
          width: size,
          height: size,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              /*Image.asset(
                'assets/mandala.png',
                fit: BoxFit.cover,
              ),*/
              Positioned(
                top: size * 0.256,
                left: size * 0.254,
                child: Container(
                  width: size * 0.49,
                  height: size * 0.49,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Colors.transparent, Colors.black26],
                        stops: [0.1, 0.8]),
                  ),
                  child: ClipOval(
                    child: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: widget.timeLines.map((TimeLineApp p) {
                        return TimeLineViewImg(
                            imgAssetPath: p.imgAssetPath, planetName: p.name);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -size * 0.5,
                child: RotationTransition(
                  turns: _smokeAnimController,
                  child: Image.asset(
                    'assets/spacesmoke.png',
                    fit: BoxFit.cover,
                    color: Colors.white,
                    width: size,
                    height: size,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
