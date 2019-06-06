import 'dart:math';

import 'package:baobab_app/blocs/timeline/time_line_bloc.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:flutter/material.dart';

import 'timeline_widget.dart';

class TimeLineSelector extends StatefulWidget {
  final Size screenSize;
  final int currentPlanetIndex;
  final Function onArrowClick;
  final VoidCallback onPlanetClicked;
  final List<TimeLineApp> timeLines;

  TimeLineSelector({
    this.screenSize,
    this.currentPlanetIndex,
    this.onArrowClick,
    this.onPlanetClicked,
    this.timeLines,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    timeLines.length;
    return _TimeLineSelectorState();
  }
}

class _TimeLineSelectorState extends State<TimeLineSelector> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _rotationTween;

  double get _widgetHeight => widget.screenSize.height * 0.47;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _rotationTween = Tween<double>(
      begin: 0.0,
      end: widget.currentPlanetIndex.toDouble(),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(TimeLineSelector oldWidget) {
    if (widget.currentPlanetIndex != oldWidget.currentPlanetIndex) {
      _rotationTween = Tween<double>(
        begin: _rotationTween.evaluate(_controller),
        end: widget.currentPlanetIndex.toDouble(),
      );

      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget _selectorRing() {
    return Container(
      width: _widgetHeight,
      height: _widgetHeight,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: FadeTransition(
        opacity: _controller,
        child: GestureDetector(
          onTap: () {
            widget.onPlanetClicked();
          },
          child: Container(
            padding: const EdgeInsets.only(top: 40.0),
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 2.5),
                )),
            child: Text(
              //"",
              '${widget.timeLines[widget.currentPlanetIndex].name.toUpperCase()}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _leftArrowButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: FractionalTranslation(
        translation: Offset(1.0, -0.5),
        child: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 35.0,
          ),
          onPressed: widget.currentPlanetIndex == 0
              ? null
              : () {
            widget.onArrowClick(ClickDirection.Left);
          },
        ),
      ),
    );
  }

  Widget _rightArrowButton() {
    return Align(
      alignment: Alignment.topRight,
      child: FractionalTranslation(
        translation: Offset(-1.0, -0.5),
        child: IconButton(
          icon: Icon(
            Icons.chevron_right,
            size: 35.0,
          ),
          onPressed: widget.currentPlanetIndex == widget.timeLines.length - 1
              ? null
              : () {
            widget.onArrowClick(ClickDirection.Right);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stackChildren = [_leftArrowButton(), _selectorRing(), _rightArrowButton()];

    TimeLineAppBLoc _timeLineAppBLoc = TimeLineAppBLoc();

    _timeLineAppBLoc.timeLineFilter.add(widget.timeLines[widget.currentPlanetIndex].id);

    for (int i = 0; i < widget.timeLines.length; i++) {
      final double radialOffset = _widgetHeight / 2;
      final double radianDiff = (2 * pi) / widget.timeLines.length;
      final double rotationFactor = _rotationTween.animate(_controller).value;
      final double startRadian = -pi / 2 + -rotationFactor * radianDiff;
      final double radians = startRadian + i * radianDiff;
      final double dx = radialOffset * cos(radians);
      final double dy = radialOffset * sin(radians);

      stackChildren.add(
        Transform.translate(
            offset: Offset(dx, dy),
            child: StreamBuilder<List<Achievement>>(
              stream: _timeLineAppBLoc.achievementStream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                if(snap.data==null){
                  List<Achievement> achievements = [];
                  widget.timeLines[i].achievements = achievements;
                }else {
                  widget.timeLines[i].achievements = snap.data;
                }
                if (snap != null) {
                  return TimeLineWidget(
                      timeLine: widget.timeLines[i], currentlyInMainPos: i == widget.currentPlanetIndex);
                }
              },
            )),
      );
    }

    return Container(
      height: _widgetHeight,
      child: Stack(
        alignment: Alignment.center,
        children: stackChildren,
      ),
    );
  }
}

enum ClickDirection { Left, Right }
