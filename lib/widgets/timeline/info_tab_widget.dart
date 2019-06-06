import 'dart:io';
import 'dart:math';

import 'package:baobab_app/models.dart';
import 'package:baobab_app/pages/music/now_playing.dart';
import 'package:flutter/material.dart';

class InfoTabs extends StatelessWidget {
  final CelestialBody planet;
  final TabController tabController;
  final List<Widget> tabs;
  final Random _random = Random();

  InfoTabs({this.planet, this.tabController, this.tabs});

  dynamic getImage(String song) {
    print("song" + song);
    return song == null ? null : new File.fromUri(Uri.parse("https://www.gstatic.com/webp/gallery/1.jpg"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        TabBar(
          controller: tabController,
          tabs: tabs,
          labelPadding: EdgeInsets.all(0.0),
          labelColor: Colors.grey.shade600,
          labelStyle: TextStyle(letterSpacing: 3.0),
          indicatorColor: Colors.grey.shade600,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.label,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              _buildInfo(
                context,
                heading: planet.name,
                intro: planet.intro,
                subHeading: 'Tu día',
                desc: planet.formation,
              ),
              GridView.builder(
                itemCount: 10,
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey,
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  ListView _buildInfo(BuildContext context, {String heading, String subHeading, String intro, String desc}) {
    return ListView(
      padding: EdgeInsets.all(25.0),
      children: <Widget>[
        Text(
          ' $heading',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30.0),
        Text(
          '$intro',
          style: TextStyle(height: 1.25),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
        new Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
          child: new Text(
            "Tus meditaciones!",
            style: new TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15.0, letterSpacing: 2.0, color: Colors.black.withOpacity(0.75)),
          ),
        ),
       // recentW(),
        Text(
          '$subHeading',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 30.0),
        Text(
          '$desc',
          style: TextStyle(height: 1.25),
        ),
      ],
    );
  }


}
