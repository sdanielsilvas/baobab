import 'dart:ui' as ui;

import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/stories/stories_page.dart';
import 'package:baobab_app/routes.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeLinePage extends StatefulWidget {
  final TimeLineApp currentTimeLine;

  TimeLinePage({this.currentTimeLine});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TimeLinePageState();
  }
}

class _TimeLinePageState extends State<TimeLinePage> with TickerProviderStateMixin {
  Offset _verticalDragStart;
  AnimationController _swipeAnimController;
  AnimationController _slideInAnimController;
  AnimationController _onNavigationAnimController;
  final PageController controller = new PageController();
  TabController _tabController;
  StoriesBloc storiesBloc = StoriesBloc();

  @override
  void initState() {
    super.initState();
    _swipeAnimController = AnimationController(duration: Duration(milliseconds: 600), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _slideInAnimController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    print("tamanio" + widget.currentTimeLine.achievements.length.toString());
    _tabController = TabController(initialIndex: 0, vsync: this, length: widget.currentTimeLine.achievements.length);

    _slideInAnimController.forward();
    _onNavigationAnimController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
  }

  @override
  void dispose() {
    _swipeAnimController.dispose();
    _tabController.dispose();
    _slideInAnimController.dispose();
    _onNavigationAnimController.dispose();
    super.dispose();
  }

  Animation<RelativeRect> _planetRect(Size screen) {
    print("scrool");
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(-50.0, screen.height * 0.7, -50.0, 0.0),
      end: RelativeRect.fromLTRB(-50.0, screen.height, -50.0, -screen.height),
    ).animate(_swipeAnimController);
  }

  Animation<RelativeRect> _moonsRect(Size screen) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, screen.height * 0.45, 0.0, screen.height * 0.425),
      end: RelativeRect.fromLTRB(-50.0, screen.height * 0.7, -50.0, 0.0),
    ).animate(_swipeAnimController);
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _verticalDragStart = details.globalPosition;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    // _slideInAnimController.forward();
    if (widget.currentTimeLine.achievements.length > 0) {
      if (_verticalDragStart.dy - details.globalPosition.dy > 50.0) {
        print("1");
        _swipeAnimController.reverse();
        _slideInAnimController.forward();
      }

      if (_verticalDragStart.dy - details.globalPosition.dy < 0.0) {
        print("0");
        _swipeAnimController.forward();
        _slideInAnimController.reverse();
      }
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    print("end");
    _verticalDragStart = null;
    // _animationController.reverse();
  }

  Widget _buildMoons(Size screenSize) {
    final double moonsWidgetHeight = 0.125 * screenSize.height;
    return TabBarView(
      controller: _tabController,
      children: widget.currentTimeLine.achievements.map((Achievement moon) {
        return Stack(
          overflow: Overflow.visible,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0.2 * moonsWidgetHeight,
              right: 0.0,
              left: 0.0,
              bottom: -(0.15 * moonsWidgetHeight),
              child: Hero(
                tag: '${moon.name}',
                child: CelestialBodyWidget(imagePath: moon.vidAssetPath),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
              right: 0.0,
              left: 0.0,
              top: 1.1 * moonsWidgetHeight * _swipeAnimController.value,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _swipeAnimController.value.clamp(0.4, 1.0),
                child: Hero(
                  tag: '${moon.name}heading',
                  child: Text(
                    moon.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white, letterSpacing: 10.0),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: screenSize.width * 0.3,
              left: screenSize.width * 0.3,
              child: FadeTransition(
                opacity: _swipeAnimController,
               // child: _descriptionColumn(moon, true),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Column _descriptionColumn(CelestialBody celestialBody, bool isMoon) {
    // print("celestial"+celestialBody.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          celestialBody.description,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
        // swiped ? Colors.grey : Colors.white,
        isMoon
            ? FlatButton(
                child: Text(
                  'Comenzar ',
                  style: TextStyle(
                    color: Colors.white54,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  _onNavigationAnimController.forward();
                  /* Navigator.of(context)
                      .push(
                    HomePageRoute(
                      transDuation: Duration(milliseconds: 600),
                      builder: (BuildContext context) {
                        return TimeLineDetailsPage(
                          selected: celestialBody,
                        );
                      },
                    ),
                  )*/

                  //Todo new route

                  Navigator.of(context)
                      .push(
                    HomePageRoute(
                      transDuation: Duration(milliseconds: 600),
                      builder: (BuildContext context) {
                        return BlocProvider(
                          bloc: storiesBloc,
                          child: StoriesWidget(),
                        );
                      },
                    ),
                  )
                      .then((_) {
                    _onNavigationAnimController.reverse();
                  });
                },
              )
            : Container(
                child: Padding(padding: EdgeInsets.symmetric(vertical: 44.0)),
              ),
      ],
    );
  }

  Container _buildSwipeIndicator(bool swiped) {
    return Container(
      width: 5.0,
      height: 5.0,
      decoration: BoxDecoration(
        color: swiped ? Colors.grey : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // widthX = width;

    final List<Widget> list = [];
    [1, 2, 3, 4].forEach((int item) {
      list.add(Container(
          color: item % 2 == 0 ? Color(0xff39a9ed) : Color(0xff66c6f2),
          child: Align(
              alignment: Alignment.center,
              child: Text(item.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0)))));
    });

    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Material(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              right: -120 + (10.0 * (_swipeAnimController.value)),
              top: -300,
              child: IgnorePointer(
                ignoring: true,
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0)).animate(_onNavigationAnimController),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.05).animate(_swipeAnimController),
                    child: Image.asset(
                      'assets/flare.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            PositionedTransition(
              rect: _planetRect(screenSize),
              child: Hero(
                tag: widget.currentTimeLine.name,
                child: CelestialBodyWidget(imagePath: widget.currentTimeLine.vidAssetPath),
              ),
            ),
            PositionedTransition(
              rect: _moonsRect(screenSize),
              child: _buildMoons(screenSize),
            ),

             Positioned(
              right: -120 + (10.0 * (_swipeAnimController.value)),
              top: -800,
              child: IgnorePointer(
                ignoring: true,
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0)).animate(_onNavigationAnimController),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.05).animate(_swipeAnimController),
                    child: Image.asset(
                      'assets/flare.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            // _buildMusicPlayer()
            //  ,

            widget.currentTimeLine.achievements.length > 0
                ? Positioned(
                    top: screenSize.height * 0.65,
                    bottom: screenSize.height * 0.325,
                    right: 0.0,
                    left: 0.0,
                    child: Column(
                      children: <Widget>[
                        _buildSwipeIndicator(_swipeAnimController.value < 1.0),
                        SizedBox(height: 3.0),
                        _buildSwipeIndicator(_swipeAnimController.value > 0.0),
                      ],
                    ),
                  )
                : Container(),

            Positioned(
              bottom: 0.0,
              right: screenSize.width * 0.15,
              left: screenSize.width * 0.15,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 1.0),
                  end: Offset(0.0, 0.0),
                ).animate(_slideInAnimController),
                child: FadeTransition(
                  opacity: _slideInAnimController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: '${widget.currentTimeLine.name}heading',
                        child: Text(
                          widget.currentTimeLine.name.toUpperCase(),
                          style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white, letterSpacing: 10.0),
                        ),
                      ),
                    //  _descriptionColumn(widget.currentTimeLine, false),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicPlayer() {
    double width = MediaQuery.of(context).size.width;

    return Positioned(
      child: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Image.asset("assets/img/music.jpg")),
          Positioned(
            top: width,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height - width - 400,
              width: width,
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: width - 100,
              decoration: new BoxDecoration(color: Colors.grey[900].withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, Achievements carouselIndex) {
    print("d");

    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(carouselIndex.name),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem();
            },
          ),
        )
      ],
    ));
  }

  Widget _buildCarouselItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Achievements choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.name, style: textStyle),
          ],
        ),
      ),
    );
  }
}
