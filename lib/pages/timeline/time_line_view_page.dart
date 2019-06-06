import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/playlist/play_list_home_page.dart';
import 'package:baobab_app/pages/stories/stories_page.dart';
import 'package:baobab_app/routes/home_page_routes.dart';
import 'package:baobab_app/widgets/standard_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeLinePageView extends StatefulWidget {
  final TimeLineApp currentTimeLine;

  TimeLinePageView({Key key, this.currentTimeLine}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimeLinePageView();
}

class _TimeLinePageView extends State<TimeLinePageView> {
  PageController _controller;
  int currentPage = 0;
  StoriesBloc storiesBloc = StoriesBloc();

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black45),
        title: Text(
          widget.currentTimeLine.name,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(microseconds: 5000),
            color: Colors.white70,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(),
              ),
              Container(
                height: queryData.size.height * 0.35,
                child: PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return item(index);
                  },
                  itemCount: widget.currentTimeLine.achievements.length,
                  controller: _controller,
                  pageSnapping: true,
                  onPageChanged: _onPageChange,
                ),
              ),
              _details(currentPage),
              FlatButton(
                onPressed: () {
                  print("menu");

                  _goPage();
                },
                child: Text(
                  "Continuar",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget item(index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1;
        if (_controller.position.haveDimensions) {
          value = _controller.page - index;
          value = (1 - value.abs() * 0.5);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) * 500,
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.currentTimeLine
                                    .achievements[currentPage].img),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              )))
                      /*child: Image.network(
                        widget.currentTimeLine.achievements[currentPage].img,
                        fit: BoxFit.cover,
                      ),*/

                      ),
                ),
              ),
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height:
                  Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                      500,
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      widget.currentTimeLine.achievements[currentPage].img,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  _onPageChange(int index) {
    setState(() {
      print("CurrentIndex => $index");
      currentPage = index;
    });
  }

  Widget _details(index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 1;
        if (_controller.position.haveDimensions) {
          value = _controller.page - index;
          value = (1 - value.abs() * 0.5);
        }

        return Expanded(
          child: Transform.translate(
            offset: Offset(0, 500 - (value * 500)),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: new Text(
                        widget.currentTimeLine.achievements[index].name,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Expanded(
                        child: new SingleChildScrollView(
                            child: Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 20, bottom: 20),
                      child: Text(
                          widget
                              .currentTimeLine.achievements[index].description,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        textAlign: TextAlign.left,
                      ),
                    ))),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: 90.0,
                      height: 5.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _goPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayListHomePage(
                achievement:
                    widget.currentTimeLine.achievements[currentPage])));
  }
}
