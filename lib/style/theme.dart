import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color splashSingleStart = const Color(0xFF129FD7);
  static const Color splashSingleEnd = const Color(0xFF0063AB);
  static const Color loginGradientStart = const Color(0xFF25639D);
  static const Color loginGradientEnd = const Color(0xFF5AB8DB);

  static const kGradientStartColor = const Color(0XFF8288E0);
  static const kGradientEndColor = const Color(0XFF7871C0);
  static const kColorPrimary =  kGradientStartColor;
  static const kColorPrimaryDark = const Color(0XFF7A70AD);
  static const kColorMinor = const  Color(0xFF99D3A7);
  static const kButtonColor = kColorPrimary;



  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,

  );
}