class ArtistInfo {
  Artist artist;

  ArtistInfo({this.artist});
}

class Artist {
  String name;
  String mbid;
  String url;
  List<ImageX> image;
  String streamable;
  String ontour;
  Stats stats;

  //Similar similar;
  //Tags tags;
  // Bio bio;

  Artist({
    this.name,
    this.mbid,
    this.url,
    this.image,
    this.streamable,
    this.ontour,
    this.stats,
    //   this.similar,
    //     this.tags,
    //     this.bio
  });
}

class ImageX {
  String text;
  String size;

  ImageX({this.text, this.size});
}

class Stats {
  String listeners;
  String playcount;

  Stats({this.listeners, this.playcount});
}
