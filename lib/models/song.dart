class Song {
  String id;
  String artist;
  String title;
  String album;
  int albumId;
  int duration;
  String uri;
  String albumArt;

  Song({this.id, this.artist, this.title, this.album, this.albumId, this.duration, this.uri, this.albumArt});

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
        id: map['id'],
        artist: map['artist'],
        album: 'album',
        albumId: map['albumId'],
        duration: map['duration'],
        title: map['title'],
        uri: map['uri'],
        albumArt: map['albumArt']);
  }
}
