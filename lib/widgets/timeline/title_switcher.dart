import 'package:baobab_app/models/time_line_app.dart';
import 'package:flutter/material.dart';

class TitleSwitcher extends StatelessWidget {
  final TimeLineApp currentTimeLine;

  final List<Title> titles = [
    Title("Fashion Talk", "Kyiv", "Nov 24, 2018"),
    Title("Kabali show", "Kyiv", "Nov 25, 2018"),
    Title("Yoke Party", "Kyiv", "Nov 24, 2018"),
  ];

  final ScrollController scrollController;

  TitleSwitcher({Key key, this.scrollController, this.currentTimeLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        controller: scrollController,
        children: currentTimeLine.achievements.map((item)=>EventTitle(Title(item.name,
            item.description, "name"))).toList()
      ),
    );
  }
}

class Title {
  final String title;
  final String location;
  final String date;

  Title(this.title, this.location, this.date);
}

class EventTitle extends StatelessWidget {
  final Title title;

  const EventTitle(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: SizedBox(
        height: 60.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title.title,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                  Text(
                    title.location,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                title.date,
                style: TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}