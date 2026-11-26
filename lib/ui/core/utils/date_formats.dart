import 'package:clean_architecture/core/utils/extensions/datetime_extension.dart';
import 'package:intl/intl.dart';

/// Display formats for dates and times.
abstract final class DateFormats {
  static final _weekdayDay = DateFormat('EEE, d MMM');
  static final _fullDate = DateFormat('d MMM y');
  static final _time = DateFormat.jm();
  static final _dateTime = DateFormat('d MMM y, h:mm a');
  static final _longDate = DateFormat('EEEE, d MMMM');

  /// `Today`, `Tomorrow`, `Yesterday`, else `Mon, 3 Feb`, plus the time when
  /// one is set. [today]/[tomorrow]/[yesterday] come from the message catalog.
  static String relativeDay(
    DateTime date, {
    required String today,
    required String tomorrow,
    required String yesterday,
    DateTime? now,
  }) {
    final day = switch (date.daysFromToday(now)) {
      0 => today,
      1 => tomorrow,
      -1 => yesterday,
      _ => _weekdayDay.format(date),
    };
    return date.hasTime ? '$day · ${_time.format(date)}' : day;
  }

  static String date(DateTime date) => _fullDate.format(date);

  static String time(DateTime date) => _time.format(date);

  static String dateTime(DateTime date) => _dateTime.format(date);

  /// `Wednesday, 26 November`.
  static String longDate(DateTime date) => _longDate.format(date);
}
