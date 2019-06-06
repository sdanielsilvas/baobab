import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:flutter/material.dart';

class ArtistDetailInfo extends StatefulWidget {
  final String artist;
  final PlayList artistSong;
  final int mode;

  ArtistDetailInfo({this.artist, this.artistSong, this.mode});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ArtistDetailInfoState();
  }
}

class _ArtistDetailInfoState extends State<ArtistDetailInfo> {
  ArtistInfo artist;
  var albumArt;
  String summary;

  @override
  Widget build(BuildContext context) {
    return decide();
  }

  decide() {
    switch (widget.mode) {
      case 0:
        return Container();
        break;
      case 1:
        //  return artist!=null ? _similarArtist():Container();
        break;
      case 2:
        // return artist!=null ? forModeTwo() : Container();
        break;
    }
  }

  Widget forModeZero() {
    return widget.artist != null
        ? artist.artist.image != null
            ? Image.network(
                artist.artist.image.toList()[3].text,
                fit: BoxFit.cover,
              )
            : albumArt != null
                ? Image.file(
                    albumArt,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "images/artist.jpg",
                    fit: BoxFit.cover,
                  )
        : Image.file(
            albumArt,
            fit: BoxFit.cover,
          );
  }
}
