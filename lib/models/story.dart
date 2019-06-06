import 'package:baobab_app/models.dart';

List<Story> stories = <Story>[
  Story(
      id: "1",
      title: "Meditacion Dia uno",
      storyContent: "Genial",
      hero: "hero",
      storyDate: "20190101",
      storyImage: "https://www.adab.red/wp-content/uploads/2016/11/relajacion-progresiva.jpg"),
  Story(
      id: "2",
      title: "Meditacion  dia 2",
      storyContent: "Genial",
      hero: "hero",
      storyDate: "2010",
      storyImage: "https://www.adab.red/wp-content/uploads/2016/11/relajacion-progresiva.jpg"),
  Story(
      id: "3",
      title: "Hola mundo",
      storyContent: "Genial",
      hero: "hero",
      storyDate: "2010",
      storyImage: "https://www.adab.red/wp-content/uploads/2016/11/relajacion-progresiva.jpg"),
];

class Story {
  String id;
  String title;
  String storyContent;
  String storyImage;
  String storyDate;
  String hero;
  final Map<Song, dynamic> playList;

  Story({this.id, this.title, this.storyContent, this.storyImage, this.storyDate, this.hero, this.playList});

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
        id: map['id'],
        title: map['title'],
        hero: map['hero'],
        storyDate: map['storyDate'],
        storyContent: map['storyContent'],
        storyImage: map['storyImage'],
        playList: map['playlist'] != null
            ? Song(
                id: map['id'],
                artist: map['artist'],
                album: 'album',
                albumId: map['albumId'],
                duration: map['duration'],
                title: map['title'],
                uri: map['uri'],
                albumArt: map['albumArt'])
            : Map());
  }
}
