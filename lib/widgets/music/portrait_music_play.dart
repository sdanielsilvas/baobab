import 'dart:async';
import 'dart:ui' as ui;

import 'package:audioplayer/audioplayer.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

import 'artist_detail_info.dart';

class PortraitMusic extends StatefulWidget {
  final AudioPlayer audioPlayer;

  final PlayList song;
  bool showArtistImage;

  PortraitMusic({this.audioPlayer, this.song, this.showArtistImage = false});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _PortraitMusicState();
  }
}

class _PortraitMusicState extends State<PortraitMusic>
    with SingleTickerProviderStateMixin {
  double widthX;
  double sHeightX;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  AnimationController _animationController;
  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;
  Duration duration;
  Duration position;
  bool isPlaying = false;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  @override
  void initState() {
    initAnim();
    initAudioPlayer();
    playPause();
  }

  void initAudioPlayer() {
    widget.song;
    _positionSubscription = widget.audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        widget.audioPlayer.onPlayerStateChanged.listen((s) {
          if (s == AudioPlayerState.PLAYING) {
            setState(() => duration = widget.audioPlayer.duration);
          } else if (s == AudioPlayerState.STOPPED) {
            onComplete();
            setState(() {
              position = duration;
            });
          }
        }, onError: (msg) {
          setState(() {
            //  playerState = PlayerState.stopped;
            duration = new Duration(seconds: 0);
            position = new Duration(seconds: 0);
          });
        });
  }

  //void playPause() {
  Future playPause() async {
    if (isPlaying) {
      await widget.audioPlayer.pause();
      animateForward();
      setState(() {
        isPlaying = false;
        //  song = widget.songs[widget.index];
      });
    } else {
      await widget.audioPlayer.play(widget.song.url);
      animateReverse();
      setState(() {
        isPlaying = true;
      });
    }
  }

  animateReverse() {
    _animationController.reverse();
  }

  animateForward() {
    _animationController.forward();
  }

  void onComplete() {
    print("complete");
  }

  initAnim() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widthX = width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    sHeightX = statusBarHeight;
    final double cutRadius = 5.0;
    int isFav = 1;
    int repeatOn = 0;

    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: widget.song == null
                ? Image.asset("assets/img/music.jpg")
                : Image.asset("assets/img/music.jpg")),
        Positioned(
          top: width,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height - width,
            width: width,
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: width,
            decoration:
            new BoxDecoration(color: Colors.grey[900].withOpacity(0.5)),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: width * 0.06 * 2),
            child: Container(
              width: width - 2 * width * 0.06,
              height: width - width * 0.06,
              child: new AspectRatio(
                aspectRatio: 15 / 15,
                child: Hero(
                  tag: widget.song.id,
                  child: widget.song != null
                      ? Material(
                    color: Colors.transparent,
                    elevation: 22.0,
                    child: SwipeDetector(
                      swipeConfiguration: SwipeConfiguration(
                          horizontalSwipeMinDisplacement: 4.0,
                          horizontalSwipeMinVelocity: 5.0,
                          horizontalSwipeMaxHeightThreshold: 100.0),
                      //  onSwipeLeft: () => widget.next,
                      //  onSwipeRight: () => widget.prev,
                      child: InkWell(
                        onDoubleTap: () {
                          setState(() {
                            if (!widget.showArtistImage)
                              widget.showArtistImage = true;
                            else
                              widget.showArtistImage = false;
                          });
                        },
//                              onLongPress: _showArtistDetail,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(cutRadius),
                              image: DecorationImage(
                                  image:
                                  AssetImage("assets/img/music.jpg"),
                                  fit: BoxFit.cover)),
                          child: Stack(
                            children: <Widget>[
                              widget.showArtistImage
                                  ? Container(
                                width: width - 2 * width * 0.06,
                                height: width - width * 0.06,
                                child: ArtistDetailInfo(
                                  artist: "Artista",
                                  artistSong: widget.song,
                                  mode: 0,
                                ),
                              )
                                  : Container(),
                              /*Positioned(
                                      bottom: -width * 0.15,
                                      right: -width * 0.15,
                                      child: Container(
                                        decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: BeveledRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        width * 0.15)))),
                                        height: width * 0.15 * 2,
                                        width: width * 0.15 * 2,
                                      ),
                                    ),*/
                              /* Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 4.0, bottom: 6.0),
                                        child: Text(
                                          "3:30",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      : new Image.asset(
                    "assets/img/back.jpg",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: EdgeInsets.only(top: width * 1.11),
              child: Container(
                  height: MediaQuery.of(context).size.height - width * 1.11,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /*Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              positionText,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color(0xaa373737),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0),
                            ),
                            Container(
                              width: width * 0.85,
                              padding: EdgeInsets.only(
                                left: statusBarHeight * 0.5,
                              ),
                              child: Slider(
                                min: 0.0,
                                activeColor: Colors.blueGrey.shade400.withOpacity(0.5),
                                inactiveColor: Colors.blueGrey.shade300.withOpacity(0.3),
                                value: position?.inMilliseconds?.toDouble() ?? 0.0,
                                onChanged: (double value) => widget.audioPlayer.seek((value / 1000).roundToDouble()),
                                max:  duration == null? 0:duration.inMilliseconds.toDouble(),
                              ),
                            ),
                          ],
                        ),*/
                        Expanded(
                          child: Center(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: new Text(
                                      'Titulo',
                                      style: new TextStyle(
                                          color: Colors.black.withOpacity(0.85),
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 3.0,
                                          height: 1.5,
                                          fontFamily: "Quicksand"),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //Todo artist card
                                      /*  Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                                  return new ArtistCard(widget.db, song);
                                }));*/
                                    },
                                    child: new Text(
                                      "Artista\n",
                                      style: new TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 14.0,
                                          letterSpacing: 1.8,
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Quicksand"),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            positionText,
                            style: TextStyle(
                                fontSize: 10.0,
                                color:
                                Colors.blueGrey.shade400.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: width * 0.85,
                                padding: EdgeInsets.only(
                                  left: statusBarHeight * 0.02,
                                ),
                                child: Slider(
                                  min: 0.0,
                                  activeColor:
                                  Colors.blueGrey.shade400.withOpacity(0.5),
                                  inactiveColor:
                                  Colors.blueGrey.shade300.withOpacity(0.3),
                                  value: position?.inMilliseconds?.toDouble() ??
                                      0.0,
                                  onChanged: (double value) => widget
                                      .audioPlayer
                                      .seek((value / 1000).roundToDouble()),
                                  max: duration == null
                                      ? 0
                                      : duration.inMilliseconds.toDouble(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 105.0),
                                  child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new IconButton(
                                            icon: isFav == 0
                                                ? new Icon(
                                              Icons.favorite_border,
                                              color: Colors.blueGrey,
                                              size: 15.0,
                                            )
                                                : new Icon(
                                              Icons.favorite,
                                              color: Colors.blueGrey,
                                              size: 15.0,
                                            ),
                                            onPressed: () {
                                              //todo set favorite
                                              //  setFav(song);
                                            }),
                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 15.0)),
                                        new IconButton(
                                          splashColor: Colors.blueGrey[200],
                                          highlightColor: Colors.transparent,
                                          icon: new Icon(
                                            Icons.skip_previous,
                                            color: Colors.blueGrey,
                                            size: 32.0,
                                          ),
                                          onPressed: () {},
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 20.0, right: 20.0),
                                          child: FloatingActionButton(
                                            backgroundColor: _animateColor.value,
                                            child: new AnimatedIcon(
                                                icon: AnimatedIcons.pause_play,
                                                progress: _animateIcon),
                                            onPressed: () {
                                              playPause();
                                            },
                                          ),
                                        ),
                                        new IconButton(
                                          splashColor:
                                          Colors.blueGrey[200].withOpacity(0.5),
                                          highlightColor: Colors.transparent,
                                          icon: new Icon(
                                            Icons.skip_next,
                                            color: Colors.blueGrey,
                                            size: 32.0,
                                          ),
                                          onPressed: () {},
                                        ),
                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 15.0)),
                                        new IconButton(
                                            icon: (repeatOn == 1)
                                                ? Icon(
                                              Icons.repeat,
                                              color: Colors.blueGrey,
                                              size: 15.0,
                                            )
                                                : Icon(
                                              Icons.repeat,
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                              size: 15.0,
                                            ),
                                            onPressed: () {
                                              //todo implement repeater
                                              // repeat1();
                                            }),
                                      ]),
                                ))),
                        Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Container(

                            width: width,
                            color: Colors.white,
                            child: FlatButton(

                              //    onPressed: () => showBottomSheet(),
                              highlightColor:
                              Colors.blueGrey[200].withOpacity(0.1),
                              child: MaterialButton(
                                  elevation: 2,
                                  child: Text('Volver'),
                                  //color: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(color: Colors.blueAccent,width: 1)


                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                  }),
                              splashColor:
                              Colors.blueGrey[200].withOpacity(0.1),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ]))),
        )
      ],
    );
  }
}
