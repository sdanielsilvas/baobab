import 'package:flutter/material.dart';


class HomePageRoute extends MaterialPageRoute {

  final Duration transDuation;

  HomePageRoute({ this.transDuation = const Duration(milliseconds: 10000),
    WidgetBuilder builder,
    RouteSettings settings}): super(builder: builder, settings: settings);




  @override
  Duration get transitionDuration => transDuation;
}