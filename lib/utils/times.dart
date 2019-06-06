import 'package:intl/intl.dart';

class Times {
  ///
  ///
  ///
  static String numberMonth2NamedMonth(
      String numberedMonth, {
        bool abbreviation = true,
      }) {
    if (numberedMonth == '1' || numberedMonth == '01') {
      return abbreviation ? 'JAN' : 'Enero';
    } else if (numberedMonth == '2' || numberedMonth == '02') {
      return abbreviation ? 'FEB' : 'Febrero';
    } else if (numberedMonth == '3' || numberedMonth == '03') {
      return abbreviation ? 'MAR' : 'Marzo';
    } else if (numberedMonth == '4' || numberedMonth == '04') {
      return abbreviation ? 'APR' : 'Abril';
    } else if (numberedMonth == '5' || numberedMonth == '05') {
      return abbreviation ? 'MAY' : 'Mayo';
    } else if (numberedMonth == '6' || numberedMonth == '06') {
      return abbreviation ? 'JUN' : 'Junio';
    } else if (numberedMonth == '7' || numberedMonth == '07') {
      return abbreviation ? 'JUL' : 'Julio';
    } else if (numberedMonth == '8' || numberedMonth == '08') {
      return abbreviation ? 'AUG' : 'Agosto';
    } else if (numberedMonth == '9' || numberedMonth == '09') {
      return abbreviation ? 'SEP' : 'Septiembre';
    } else if (numberedMonth == '10') {
      return abbreviation ? 'OCT' : 'Octubre';
    } else if (numberedMonth == '11') {
      return abbreviation ? 'NOV' : 'Noviembre';
    } else if (numberedMonth == '12') {
      return abbreviation ? 'DEC' : 'Diciembre';
    } else {
      return 'UNKOWN';
    }
  }

  static String timestamp2String(int timestamp,
      {String format = 'yyyy-MM-dd hh:mm:ss'}) {
    return DateFormat(format).format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  ///
  static String time2period(DateTime time) {
    String format = 'HH';
    int hour = int.parse(DateFormat(format).format(time));
    if (hour > 6 && hour < 12) {
      return 'morning';
    } else if (hour >= 12 && hour < 18) {
      return 'afternoon';
    } else {
      return 'evening';
    }
  }

  ///
  static String currentPeriod() {
    String format = 'HH';
    int hour = int.parse(DateFormat(format).format(DateTime.now()));
    if (hour > 6 && hour < 12) {
      return 'DIAS';
    } else if (hour >= 12 && hour < 18) {
      return 'TARDES';
    } else {
      return 'NOCHES';
    }
  }

  ///
  static String currentNamedMonthDay() {
    final now = DateTime.now();
    final namedMonth = numberMonth2NamedMonth(
      now.month.toString(),
      abbreviation: false,
    );
    return '$namedMonth ${now.day}';
  }

  ///
  static String relativeDate(DateTime time) {
    final now = DateTime.now();
    final difference = now.day - time.day;
    if (difference == 0) {
      return 'HOY';
    } else if (difference == 1) {
      return 'YESTERDAY';
    } else {
      return '$difference DAYS AGO';
    }
  }
}
