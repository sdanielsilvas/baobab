import 'dart:math';

import 'package:baobab_app/models/celestial_body.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/widgets/shape/sky_widget.dart';
import 'package:flutter/material.dart';

class TimeLineWidget extends StatefulWidget {
  final TimeLineApp timeLine;
  final bool currentlyInMainPos;

  TimeLineWidget({this.timeLine, this.currentlyInMainPos});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TimeLineWidgetState();
  }
}

class _TimeLineWidgetState extends State<TimeLineWidget>
    with TickerProviderStateMixin {
  final double constDiameter = 15.0;
  final double moonOrbitRadius = 20.0;
  AnimationController _rotationController;
  AnimationController _moonOrbitLengthController;
  Animation<double> _moonOrbitLength;

  AnimationController animControlBtnLongPress, animControlBox;
  Animation zoomIconChosen, zoomIconNotChosen;
  AnimationController animControlIconWhenDragInside;
  Animation zoomIconWhenDragInside;
  Animation zoomIconWhenDragOutside;
  Animation zoomIconLike;
  Animation zoomIconLikeInBtn;

  int durationAnimationBtnLongPress = 150;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationBox = 500;

  int currentIconFocus = 1;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;
  List colors = [Colors.blue, Colors.cyan, Colors.lightBlueAccent];
  Color colorMoon ;
  Random random = new Random();



  @override
  void initState() {

    super.initState();
    _rotationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);


    _moonOrbitLengthController =
    AnimationController(duration: Duration(milliseconds: 700), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _moonOrbitLength = Tween<double>(begin: 0.0, end: moonOrbitRadius)
        .animate(_moonOrbitLengthController);
    _moonOrbitLengthController.forward();

    initAnimationBtnLike();
    initAnimationBoxAndIcons();
    initAnimationIconWhenDragInside();
  }

  @override
  void didUpdateWidget(TimeLineWidget oldWidget) {
    if (widget.currentlyInMainPos != oldWidget.currentlyInMainPos) {
      _moonOrbitLengthController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
    // super.initState();
  }

  @override
  dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  bool get hasMoons => widget.timeLine.achievements.length > 0;

  Widget paint() {
    return CustomPaint(
      painter: Sky(),
      child: Center(
        child: Text(
          's',
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _buildCelestialBody(
      {@required CelestialBody body, bool isMoon, bool isview}) {






    if (hasMoons) {
      _rotationController.repeat();
    }
    return GestureDetector(
      child: Center(
        child: isMoon
            ? Container(
          width: body.diameter * constDiameter,
          height: body.diameter * constDiameter,
          decoration: BoxDecoration(
            color: colorMoon,
            shape: BoxShape.circle,
          ),
          //child: paint(),
        )
            : Container(
          width: isview ? body.diameter * 15.0 : body.diameter * 10,
          height:
          isview ? body.diameter * 30 : body.diameter * constDiameter,
          decoration: BoxDecoration(
            color: isview ? body.color : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
      ),
      onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
    );
    // return
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
    print(dragUpdateDetail.primaryDelta);
    if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
      animControlIconWhenDragInside.reset();
      animControlIconWhenDragInside.forward();
    }
  }

  Widget renderIcons(CelestialBody body, bool isview) {
    /* return Container(
             width: isview ? body.diameter * 15.0 : body.diameter * 10,
              height:
              isview ? body.diameter * 30 : body.diameter * constDiameter,
              decoration: BoxDecoration(
                color: isview ? body.color : Colors.grey.shade300,
                shape: BoxShape.circle,
              ));*/
    return Container(
        child: Row(children: <Widget>[
          // Transform.scale(
          Container(
            child: Column(
              children: <Widget>[
                currentIconFocus == 1
                    ? Container(
                  child: Text(
                    'Like',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), color: Colors.black.withOpacity(0.3)),
                  padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                  margin: EdgeInsets.only(bottom: 8.0),
                )
                    : Container(),
                Image.asset(
                  'assets/like.gif',
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            //margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
            width: 40.0,
            height: currentIconFocus == 1 ? 70.0 : 40.0,
          ),
          /*  scale: isDragging
                ? (currentIconFocus == 0
                ? this.zoomIconChosen.value
                : (previousIconFocus == 0
                ? this.zoomIconNotChosen.value
                : isJustDragInside ? this.zoomIconWhenDragInside.value : 0.8))
                : isDraggingOutside ? this.zoomIconWhenDragOutside.value : this.zoomIconLike.value,
          ),*/
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final TimeLineApp planet = widget.timeLine;
    final List<Achievement> moons = planet.achievements;
    colorMoon =  colors[random.nextInt(3)];
    final List<Widget> bodies = [
      _buildCelestialBody(
          body: planet, isMoon: false, isview: widget.currentlyInMainPos)
    ];
    if (moons != null) {
      if (moons.length > 0 && widget.currentlyInMainPos) {
        for (int i = 0; i < moons.length; i++) {
          final double radians = (2 * pi / moons.length) * i;
          final double dx = _moonOrbitLength.value * cos(radians);
          final double dy = _moonOrbitLength.value * sin(radians);

          bodies.add(
            Transform.translate(
              offset: Offset(dx, dy),
              child: _buildCelestialBody(body: moons[i], isMoon: true),
            ),
          );
        }
      } else {
        for (int i = 0; i < moons.length; i++) {
          final double radians = (2 * pi / moons.length) * i;
          final double dx = _moonOrbitLength.value * cos(radians);
          final double dy = _moonOrbitLength.value * sin(radians);
        }
      }
    }

    return RotationTransition(
      turns: _rotationController,
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Stack(
          overflow: Overflow.visible,
          children: bodies,
        ),
      ),
    );
  }

  initAnimationBtnLike() {
    animControlBtnLongPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationAnimationBox));
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
  }
}
