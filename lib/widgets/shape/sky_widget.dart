import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Sky extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    _drawSky(canvas, rect);
    _drawSun(canvas, rect);
  }

  void _drawSky(Canvas canvas, Rect rect) {
    var skyGradient = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.fromRGBO(135, 202, 255, 1.0), Color.fromRGBO(226, 242, 255, 1.0)],
        stops: [0.0, 1.0]);

    canvas.drawRect(
      rect,
      new Paint()..shader = skyGradient.createShader(rect),
    );
  }

  void _drawSun(Canvas canvas, Rect rect) {
    var gradient = new RadialGradient(center: const Alignment(0.2, -1.2), radius: 0.8, colors: [const Color(0xFFFFFF55), const Color(0x00FFFF00)]);

    canvas.drawRect(
      rect,
      new Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(Sky oldDelegate) => false;
}

