import 'package:baobab_app/models/time_line_app.dart';

class TimeLineState  {
  final String error;
  final bool isInitialising;
  final List<TimeLineApp> timeLines;

  TimeLineState({this.timeLines, this.isInitialising, this.error});

  factory TimeLineState.initialising() {
    return TimeLineState(
      error: null,
      isInitialising: true,
      timeLines: null,
    );
  }

  factory TimeLineState.failure(String error) {
    return TimeLineState(
      timeLines: null,
      isInitialising: false,
      error: error,
    );
  }

  factory TimeLineState.normal(List<TimeLineApp> timeLines) {
    return TimeLineState(
      timeLines: timeLines,
      isInitialising: false,
      error: '',
    );
  }
}
