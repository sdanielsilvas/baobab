import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef Widget Builder(BuildContext context, AnimationController controller);

enum SlideDirection {
  vertical,
  horizontal,
}

class FadeSlideTransition extends StatefulWidget {
  final Builder builder;

  final Offset originOffset;

  final Duration delay;

  final Duration duration;

  final Curve fadeCurve;

  final Curve slideCurve;

  final Curve slideReverseCurve;

  final SlideDirection direction;

  final bool immediately;

  FadeSlideTransition({
    this.originOffset = const Offset(0.0, 30.0),
    this.delay = const Duration(milliseconds: 0),
    this.duration = const Duration(milliseconds: 700),
    this.fadeCurve = Curves.decelerate,
    this.slideCurve = Curves.decelerate,
    this.slideReverseCurve = Curves.decelerate,
    this.direction = SlideDirection.vertical,
    this.immediately = true,
    this.builder,
  });

  @override
  _FadeInSlideTransitionState createState() {
    return _FadeInSlideTransitionState();
  }
}

class _FadeInSlideTransitionState extends State<FadeSlideTransition> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _slideAnimation;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.slideCurve,
      reverseCurve: widget.slideReverseCurve,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.fadeCurve,
    );

    if (widget.immediately) {
      Observable.just('').delay(widget.delay).listen((_) => _controller.forward());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.originOffset,
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.builder(context, _controller),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              widget.direction == SlideDirection.horizontal ? -_slideAnimation.value * widget.originOffset.dx : 0.0,
              widget.direction == SlideDirection.vertical ? -_slideAnimation.value * widget.originOffset.dy : 0.0,
            ),
            child: Opacity(opacity: _fadeAnimation.value, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
