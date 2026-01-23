import 'package:intl/intl.dart';

extension TimeExtensions on DateTime? {
  /// Format a date time in day.month.year - hours:minutes.
  String toFormatDateTime({String? elseText}) {
    return this == null
        ? elseText ?? ''
        : DateFormat('dd.MM.yyyy - HH:mm').format(this!);
  }

  /// Format a date time in day.month.year.
  String toFormatDate({String? elseText}) {
    return this == null
        ? elseText ?? ''
        : DateFormat('dd.MM.yyyy').format(this!);
  }

  /// Format a date time in hours:minutes.
  String toFormatTime({String? elseText}) {
    return this == null
        ? elseText ?? ''
        : DateFormat('HH:mm').format(this!);
  }

  /// Format a date time in calender weeks.
  int toWeekNumber() {
    if (this == null) {
      return 0;
    }

    // Determine the day of the week (1 for Monday, 7 for Sunday)
    final int dayOfWeek = this!.weekday;

    // Calculate the first day of the week (Monday)
    final DateTime firstDayOfWeek = this!.subtract(Duration(days: dayOfWeek - 1));

    // Calculate the difference in days as of January 1 of the year
    final int daysSinceEpoch = firstDayOfWeek.difference(DateTime(firstDayOfWeek.year, 1, 1)).inDays;

    // Calculate the calendar week
    final int weekNumber = (daysSinceEpoch / 7).ceil() + 1;

    return weekNumber;
  }
}