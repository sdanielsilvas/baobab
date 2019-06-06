import 'package:baobab_app/blocs/timeline/time_event.dart';
import 'package:baobab_app/blocs/timeline/time_state.dart';
import 'package:baobab_app/database/database.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:bloc/bloc.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  String TIMELINECOLLECTION = "timeline";

  List<TimeLineApp> timeLines;

  @override
  // TODO: implement initialState
  TimeLineState get initialState {
    if (timeLines != null) {
      return TimeLineState(
          isInitialising: false, error: '', timeLines: timeLines);
    } else {
      return TimeLineState.initialising();
    }
  }

  @override
  Stream<TimeLineState> mapEventToState(
      TimeLineState currentState, TimeLineEvent event) async* {
    // TODO: implement mapEventToState

    if (event is LoadTimeLineEvent) {
      // yield TimeLineState.loading();

      try {
        timeLines = [];

        List<Map<String, dynamic>> documents = await Database
            .readDocumentsAtCollectionWithLimitByTimestampDescending(
                TIMELINECOLLECTION, 100);

        timeLines =
            documents.map((item) => TimeLineApp.fromJson(item)).toList();

        yield TimeLineState.normal(timeLines);

        /*repository.getTimeLinesApp().listen((item) {
          timeLines = item;
          for (TimeLineApp timeLineApp in item) {
            print(timeLineApp);
            repository.getAchievements(timeLineApp.id).listen((achievement) {
              timeLineApp.achievements = achievement;
            },onDone: (){
              print("done");
            });
          }
           //yield TimeLineState.normal(timeLines);
        });*/

      } catch (error) {
        yield TimeLineState.failure(error);
      }
    }
  }

  void loadTimeLineApp() {
    dispatch(LoadTimeLineEvent());
  }
}
