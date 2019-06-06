import 'package:baobab_app/models.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:baobab_app/utils/music_finder.dart';

class MyQueue {
  static List<PlayList> songs;
  static Song song;
  static int index;
  static MusicFinder player=new MusicFinder();
}