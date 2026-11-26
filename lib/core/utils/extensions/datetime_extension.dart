extension DateTimeExtension on DateTime {
  /// Midnight at the start of this day.
  DateTime get dateOnly => DateTime(year, month, day);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Whole days from today's start to this day's start (negative: past).
  int daysFromToday([DateTime? now]) =>
      dateOnly.difference((now ?? DateTime.now()).dateOnly).inDays;

  /// Whether a time was set (anything but midnight).
  bool get hasTime => hour != 0 || minute != 0;
}
