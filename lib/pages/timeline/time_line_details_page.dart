import 'package:baobab_app/models.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';

class TimeLineDetailsPage extends StatefulWidget {
  final CelestialBody selected;

  TimeLineDetailsPage({this.selected});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimeLineDetailsPageState();
  }
}

class _TimeLineDetailsPageState extends State<TimeLineDetailsPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Widget> _tabs = [
    Tab(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        child: Text('Descubre El proceso'),
      ),
    ),

    /*Tab(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        child: Text('IMAGES'),
      ),
    )*/
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    print(screenSize.height);
    return Material(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Hero(
              tag: widget.selected.name,
              child: CelestialBodyWidget(imagePath: widget.selected.vidAssetPath),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.05,
            child: Hero(
              tag: '${widget.selected.name}heading',
              child: Text(
                widget.selected.name.toUpperCase(),
                style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white, letterSpacing: 10.0),
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            top: screenSize.height * 0.2,
            bottom: 0.0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: InfoTabs(
                planet: widget.selected,
                tabController: _tabController,
                tabs: _tabs,
              ),
            ),
          )
        ],
      ),
    );
  }
}
