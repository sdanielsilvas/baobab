


import 'dart:math';

import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:baobab_app/pages/music/now_playing.dart';
import 'package:flutter/material.dart';

class PlayListWidget extends StatelessWidget{


  List<PlayList> playlist ;
  final Random _random = Random();

  PlayListWidget({this.playlist});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return recentW();
  }



  Widget recentW() {
    print("random" + _random.nextInt(10).toString());
    return new Container(
      height: 285.0,
      child: new ListView.builder(
        itemCount: playlist.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: InkWell(
            onTap: () {
              print("click me");
              /*  MyQueue.songs = recents;*/
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                //List<Song> songs = planet.songs;
                //return new Nowpa
                return new NowPlaying(playlist, 1, 1);
                // return new NowPlaying(widget.db, recents, i, 0);
              }));
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
                            height: 150.0,
                            width: 210.0,
                            child: Hero(
                                tag: i,
                                child: Stack(
                                  children: <Widget>[
                                    new Image.asset(
                                      "assets/img/back.jpg",
                                      height: 150.0,
                                      width: 210.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Align(
                                      // alignment: Alignment.bottomRight,
                                        child: _buildThumbnail(context,i)),
                                    // _buildThumbnail(),
                                  ],
                                ))),

                        SizedBox(
                            width: 180.0,
                            child: Padding(
                              // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                              padding: EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  Text(
                                    "name",
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.70)),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      "artista",
                                      style: TextStyle(fontSize: 10.0, color: Colors.black.withOpacity(0.75)),
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

  Widget _buildThumbnail(BuildContext context,int i) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          // Image.asset(video.thumbnail),
          Positioned(bottom: 12.0, right: 12.0, child: _buildPlayButton(context,i)),
        ],
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context, int i) {
    return Material(
      color: Colors.black87,
      type: MaterialType.circle,
      child: InkWell(

        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {

           print(i);
            //return new Nowpa
            return new NowPlaying(playlist, i, 1);
            // return new NowPlaying(widget.db, recents, i, 0);
          }));
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