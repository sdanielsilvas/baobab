import 'dart:async';
import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
  final int mode;
  final List<PlayList> songs;
  int index;

  //final DatabaseClient db;

  NowPlaying(this.songs, this.index, this.mode);

  @override
  State<StatefulWidget> createState() {
    return new _StateNowPlaying();
  }
}

class _StateNowPlaying extends State<NowPlaying> with SingleTickerProviderStateMixin {
  Duration duration;
  Duration position;
  bool isPlaying = false;
  PlayList song;
  int isFav = 1;
  int repeatOn = 0;
  Orientation orientation;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  bool isOpened = true;
  Animation<double> _animateIcon;
  Timer timer;
  bool _showArtistImage;
  AudioPlayer audioPlayer;

  get durationText => duration != null ? duration.toString().split('.').first.substring(3, 7) : '';

  get positionText => position != null ? position.toString().split('.').first.substring(3, 7) : '';

  @override
  void initState() {
    super.initState();
    _showArtistImage = false;
    initAnim();
    song = widget.songs[widget.index];

    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  initAnim() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.blueGrey[400].withOpacity(0.7),
      end: Colors.blueGrey[400].withOpacity(0.9),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
  }

  animateForward() {
    _animationController.forward();
  }

  animateReverse() {
    _animationController.reverse();
  }

  void initPlayer() async {
    //Future<void> play() async {
    audioPlayer = new AudioPlayer();
    // _playLocal();
    // }

    /* if (player == null) {
      player = MusicFinder();
      MyQueue.player = player;
      var pref = await SharedPreferences.getInstance();
      pref.setBool("played", true);
    }
    //  int i= await widget.db.isfav(song);
    setState(() {
      if (widget.mode == 0) {
        player.stop();
      }
      updatePage(widget.index);
      isPlaying = true;
    });
    player.setDurationHandler((d) => setState(() {
      duration = d;
    }));
    player.setPositionHandler((p) => setState(() {
      position = p;
    }));
      player.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
        if (repeatOn != 1) ++widget.index;
        song = widget.songs[widget.index];
      });
    });
    player.setErrorHandler((msg) {
      setState(() {
        player.stop();
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });*/
  }

  void updatePage(int index) {
    MyQueue.index = index;
    song = widget.songs[index];
    /*  song.timestamp = new DateTime.now().millisecondsSinceEpoch;
    if (song.count == null) {
      song.count = 0;
    } else {
      song.count++;
    }
    widget.db.updateSong(song);
    isFav = song.isFav;*/
  }

  Future _playLocal() async {
    await audioPlayer.play(widget.songs[0].url, isLocal: true);
    //setState(() => playerState = PlayerState.playing);
  }

  /*Future play() async {
    await audioPlayer.play(widget.songs[0].uri);
    setState(() {
      // playerState = PlayerState.playing;
    });
  }*/

  void playPause() {}

  Future next() async {}

  Future prev() async {}

  void onComplete() {
    next();
  }

  dynamic getImage(Song song) {
    return song == null ? null : new File.fromUri(Uri.parse(song.albumArt));
  }

  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      key: scaffoldState,
      body: song != null
          ? orientation == Orientation.portrait
              ? PortraitMusic(
                  song: song,
                  audioPlayer: audioPlayer,
                )
              : PortraitMusic(song: song, audioPlayer: audioPlayer)
          : Center(
              child: CircularProgressIndicator(),
            ),
      backgroundColor: Colors.transparent,
    );
  }

  void _showBottomSheet() {}
}
