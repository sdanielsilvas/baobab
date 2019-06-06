class PlayList {

  String id;
  String url;
  String albumArt;
  String title;
  String artist;
  int duration;

  PlayList.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    url = json["url"];
  }

}


