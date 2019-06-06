import 'package:baobab_app/database/database.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:rxdart/rxdart.dart';

class TimeLineAppBLoc {
  TimeLineAppBLoc() {
    _timeLineFilterSubject.stream.listen(_handleGetAchievement);
    _getDataTimeLine();
  }

  final BehaviorSubject<List<TimeLineApp>> _timeLineApp = BehaviorSubject<List<TimeLineApp>>();

  Sink<List<TimeLineApp>> get timeLineSink => _timeLineApp.sink;

  Stream<List<TimeLineApp>> get timeLineStream => _timeLineApp.stream;

  String TIMELINECOLLECTION = "timeline";

  static const String ACHIEVEMENT_COLLECTION = 'achievements';

  final _timeLineFilterSubject = BehaviorSubject<String>();

  Sink<String> get timeLineFilter => _timeLineFilterSubject.sink;

  final BehaviorSubject<List<Achievement>> _achievement = BehaviorSubject<List<Achievement>>();

  Sink<List<Achievement>> get achievementSink => _achievement.sink;

  Stream<List<Achievement>> get achievementStream => _achievement.stream;

  _getDataTimeLine() {
    try {
      Database.readDocumentsAtCollectionWithLimitByTimestampDescending(TIMELINECOLLECTION, 100).then((item) {
        timeLineSink.add(item.map((value) => TimeLineApp.fromJson(value)).toList());
      });
    } catch (error) {}
  }

  _getAchievements() {}

  @override
  void dispose() {
    _timeLineApp.close();
    _timeLineFilterSubject.close();
    _achievement.close();
  }

  void _handleGetAchievement(String event) {
    try {
      Database.readDocumentsSubCollection(event, TIMELINECOLLECTION, ACHIEVEMENT_COLLECTION, 100).then((item) {
        if (item !=null)
        achievementSink.add(item.map((values) =>  Achievement.fromJson(values)).toList());
      });

    } catch (errro) {}

    print(event);
  }
}
