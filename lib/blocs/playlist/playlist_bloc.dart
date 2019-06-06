import 'package:baobab_app/database/database.dart';
import 'package:baobab_app/models/play_list.dart';
import 'package:rxdart/rxdart.dart';

class PlayListBloc {
  PlayListBloc() {
    _playListFilterSubject.stream.listen(_getPlayList);
  }

  final BehaviorSubject<List<PlayList>> _tomeLineApp =
      BehaviorSubject<List<PlayList>>();

  Sink<List<PlayList>> get _sinkPlayList => _tomeLineApp.sink;

  Stream<List<PlayList>> get streamPlayList => _tomeLineApp.stream;

  final _playListFilterSubject = BehaviorSubject<String>();

  Sink<String> get playListFilter => _playListFilterSubject.sink;

  String playListCollection = "playlist";
  String songListCollection = "song";

/*  try {
  Database.readDocumentsAtCollectionWithLimitByTimestampDescending(TIMELINECOLLECTION, 100).then((item) {
  timeLineSink.add(item.map((value) => TimeLineApp.fromJson(value)).toList());
  });
  } catch (error) {}*/

  void _getPlayList(String event) {
    try {
      Database.readDocumentsSubCollection(
              "1", playListCollection, songListCollection, 3)
          .then((item) {
        _sinkPlayList
            .add(item.map((value) => PlayList.fromMap(value)).toList());
      });
    } catch (err) {

    }
  }

  @override
  void dispose() {
    _tomeLineApp.close();
  }

//final BehaviorSubject<List<TimeLineApp>> _timeLineApp = BehaviorSubject<List<TimeLineApp>>();

}
