import 'dart:io';

import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:flutter/material.dart';

import 'now_playing.dart';

class Songs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _songsState();
  }
}

class _songsState extends State<Songs> {
  List<PlayList> songs;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSongs();
  }

  void initSongs() async {
    songs = []; //await widget.db.fetchSongs();
    setState(() {
      isLoading = false;
    });
  }

  dynamic getImage(PlayList song) {
    return song.albumArt == null ? null : new File.fromUri(Uri.parse(song.albumArt));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: isLoading
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : Scrollbar(
                child: new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: songs.length,
                  itemBuilder: (context, i) => new Column(
                        children: <Widget>[
                          new ListTile(
                            leading: Hero(
                                tag: songs[i].id,
                                child: Image.file(
                                  getImage(songs[i]),
                                  width: 55.0,
                                  height: 55.0,
                                )),
                            title: new Text(
                              songs[i].title,
                              maxLines: 1,
                              style: new TextStyle(color: Colors.black, fontSize: 16.0),
                            ),
                            subtitle: new Text(
                              songs[i].artist,
                              maxLines: 1,
                              style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            trailing: new Text(
                              new Duration(milliseconds: songs[i].duration).toString().split('.').first.substring(3, 7),
                              style: new TextStyle(fontSize: 12.0, color: Colors.black54),
                            ),
                            onTap: () {
                              print("tap");
                              MyQueue.songs = songs;
                              Navigator.of(context).push(
                                  new MaterialPageRoute(builder: (context) => new NowPlaying(MyQueue.songs, i, 0)));
                            },
                          )
                        ],
                      ),
                ),
              ),
      ),
    );
  }
}
