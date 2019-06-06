import 'package:flutter/material.dart';
import 'dart:async';

class TimeLineSwipe extends StatefulWidget {
  final GlobalKey key;

  final List<Widget> children;

  final double width;

  final double height;

  final int defaultIndex;

  final bool cycle;

  final bool indicators;

  final int playDuration;

  final bool autoPlay;

  final int duration;

  final Curve curve;

  final Function(int index) onChang;

  TimeLineSwipe({
    this.key,
    @required this.children,
    this.width,
    this.height,
    this.defaultIndex = 0,
    this.cycle = true,
    this.indicators = true,
    this.playDuration = 3000,
    this.autoPlay = false,
    this.duration = 280,
    this.curve = Curves.bounceIn,
    this.onChang
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TimeLineSwipeState() ;
  }


}

class TimeLineSwipeState extends State<TimeLineSwipe> {
  PageController _pageController;
  int _index;
  Timer _timer;
  List<Widget> _list = [];

  @override
  void initState() {
    super.initState();

    if (widget.cycle) {
      _index = widget.defaultIndex + 1;
      _list.addAll(widget.children);
      _list.add(widget.children[0]);
      _list.insert(0, widget.children[widget.children.length - 1]);
    } else {
      _list = widget.children;
      _index = widget.defaultIndex;
    }

    // PageController
    _pageController = PageController(
        initialPage: _index
    );


    if (widget.autoPlay) {
      this.autoPlay();
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopAutoPlay();
  }


  void setIndex(int index) {
    _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: widget.duration),
        curve: widget.curve
    );
  }


  void previousPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: widget.duration),
        curve: widget.curve
    );
  }


  void nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: widget.duration),
        curve: widget.curve
    );
  }

  void onChang(int index) {
    if (widget.onChang != null) {
      widget.onChang(index);
    }

    setState(() {
      _index = index;
    });
  }


  List<Widget> renderIndicators(int index) {
    final List<Widget> indicators = [];
    final double size = 7.0;

    for (var i = 0; i < widget.children.length; i++) {
      indicators.add(
          Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0.0 : 7.0),
              child: Opacity(
                  opacity: index == i ? 1.0 : 0.55,
                  child: SizedBox(
                      width: size,
                      height: size,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size)
                              )
                          )
                      )
                  )
              )
          )
      );
    }
    return indicators;
  }


  void autoPlay() {
    _timer = Timer.periodic(Duration(milliseconds: widget.playDuration), (Timer timer) {
      if (widget.cycle) {
        if (_index == widget.children.length) {
          _pageController.jumpToPage(0);
        }
        nextPage();
      } else if (_index == widget.children.length - 1) {
        setIndex(0);
      } else {
        nextPage();
      }
    });
  }


  void stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }


  onPointerDown(event) {
    if (widget.autoPlay) {
      stopAutoPlay();
    }


    if (_index == widget.children.length + 1) {
      _pageController.jumpToPage(1);
    }
  }

  // up
  onPointerUp(event) {
    if (widget.autoPlay) {
      autoPlay();
    }


    if (_index == 0) {
      _pageController.jumpToPage(widget.children.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget swipeWidget = PageView.builder(
        itemCount: _list.length,
        controller: _pageController,
        onPageChanged: onChang,
        itemBuilder:(BuildContext context, int index) {
          return _list[index];
        }
    );


    if (widget.cycle) {
      swipeWidget = Listener(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          child: swipeWidget
      );
    }


    if (widget.indicators) {
      swipeWidget = Stack(
          children: <Widget>[
            swipeWidget,
            // indicators
            Positioned(
                left: 0,
                right: 0,
                bottom: 12.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: renderIndicators(widget.cycle ? _index - 1 : _index)
                )
            )
          ]
      );
    }

    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: swipeWidget
    );
  }

}