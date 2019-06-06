import 'package:baobab_app/blocs/playlist/playlist_bloc.dart';
import 'package:baobab_app/blocs/stories/stories_bloc.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/stories/stories_page.dart';
import 'package:baobab_app/routes/home_page_routes.dart';
import 'package:baobab_app/widgets/curve-clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayListHomePage extends StatefulWidget {
  final Achievement achievement;
  final String timeLineId;

  PlayListHomePage({this.achievement,this.timeLineId});

  @override
  State<StatefulWidget> createState() => _PlayListHomePageState();
}

class _PlayListHomePageState extends State<PlayListHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightAnimation;
  Animation<double> _iconSizeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Dashboard'),
      backgroundColor: Color(0xFF0084ff),
      elevation: 0,
      actions: <Widget>[
        Icon(Icons.notifications),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff00ff1d),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: media.height,
        width: media.width,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: media.width,
                height: media.height * .20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2b7cb6),
                      Color(0xFF0084ff),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              width: media.width,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.achievement.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              top: media.height * .10,
              width: media.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffeff2f3),
                            offset: Offset(1, 5.0),
                            blurRadius: 3.0)
                      ]
                  ),

                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(padding: EdgeInsets.all(10),
                          child: Column(

                            children: <Widget>[
                              Text(widget.achievement.name)
                            ],
                          ),

                        ),
                      )
                    ],
                  ),
                ),

              ),
            ),
            Positioned(
              top: media.height * .21,
              height: (media.height * .60) ,
              width: media.width,
              child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Meditaciones",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      recentW(),
                      SizedBox(height: 5),

                    ],
                  )),
            ),
            buildNotificationPanel(media.width, media.height),
          ],
        ),
      ),
    );
  }



  Widget buildNotificationPanel(double width, double height) {
    return Positioned(
        width: width,
        height: height * .70 - 40,
        top: height * 0.42 ,
        child:
       Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Material(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildBodyCardTitle(title: "Tips"),

                    buildNotificationItem(icon: Icons.notifications_none),
                    Divider(
                      height: 1,
                      color: Colors.black87,
                    ),
                    buildNotificationItem(icon: Icons.announcement),

                   // buildNotificationItem(icon: Icons.child_friendly),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Material(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildBodyCardTitle(title: "Como te sientes"),
                    Divider(
                      height: 2,
                      color: Colors.black87,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      leading: Card(
                        elevation: 2,
                        child: Container(
                          height: 70,
                          width: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "MAY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "21",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Meditacion",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Como te Sientes despues de la meditacion",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "PENDIENTE",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 70,
                        width: 80,
                        padding: const EdgeInsets.only(right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 2),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff1abcaa),
                              ),
                              child: Text(
                                "CUENTAME",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 150),
            ],
          ),
        ),
      ));

  }

  Widget buildNotificationItem({IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white70,
          ),
        ),
        title: Text(
          "De tu familia",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Animo",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Te queremos ",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: Container(
          height: 40,
          width: 70,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1,
                color: Colors.black26,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 15,
                ),
                Text(
                  " 1 Day",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget buildBodyCardTitle({String title}) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF0084ff),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }



  Widget recentW() {
    Size media = MediaQuery.of(context).size;



    PlayListBloc bloc = PlayListBloc();
    bloc.playListFilter.add(widget.achievement.id);

   // bloc.timeLineFilter.add(widget.achievement)


    return new Container(
      height: media.height * .20,
      child: new ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: InkWell(
                onTap: () {
                  print("click me");
                  /*  MyQueue.songs = recents;*/
                },
                child: new IntrinsicHeight(
                  child: new Row(children: <Widget>[
                    new Card(
                      elevation: 12.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // _buildThumbnail(),

                            SizedBox(
                                height: media.height * .10,
                                width: 180.0,
                                child: Hero(
                                    tag: i,
                                    child: Stack(
                                      children: <Widget>[
                                        new Image.asset(
                                          "assets/img/back.jpg",
                                          height: media.height * .10,
                                          width: 180.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Align(
                                            // alignment: Alignment.bottomRight,
                                            child: _buildThumbnail(context)),
                                        // _buildThumbnail(),
                                      ],
                                    ))),

                            SizedBox(
                                width: 180.0,
                                child: Padding(
                                  // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "art",
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.70)),
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 5.0),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Text(
                                          "list",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.black
                                                  .withOpacity(0.75)),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            //_buildThumbnail()
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          // Image.asset(video.thumbnail),
          Positioned(
              bottom: 12.0, right: 12.0, child: _buildPlayButton(context)),
        ],
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context) {
    return Material(
      color: Colors.black87,
      type: MaterialType.circle,
      child: InkWell(
        onTap: () {

          StoriesBloc storiesBloc = StoriesBloc();

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
          );
          /*Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            List<Song> songs = planet.songs;
            //return new Nowpa
            return new NowPlaying(songs, 1, 1);
            // return new NowPlaying(widget.db, recents, i, 0);
          }));*/
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
