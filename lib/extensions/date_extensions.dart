import 'package:intl/intl.dart';

/// Convenience formatting and calendar helpers for nullable [DateTime].
///
/// Design choices:
/// - Defined on `DateTime?` so callers can format without null checks:
///   `myDate.toFormatDate(elseText: '-')`.
/// - Methods return empty string by default when the value is null (configurable).
extension TimeExtensions on DateTime? {
  /// Formats the date/time as `dd.MM.yyyy - HH:mm`.
  ///
  /// If this value is `null`, returns [elseText] or an empty string.
  ///
  /// Example:
  /// ```dart
  /// final text = order.createdAt.toFormatDateTime(elseText: 'n/a');
  /// ```
  String toFormatDateTime({String? elseText}) {
    return this == null
        ? elseText ?? ''
        : DateFormat('dd.MM.yyyy - HH:mm').format(this!);
  }

  /// Formats the date as `dd.MM.yyyy`.
  ///
  /// If this value is `null`, returns [elseText] or an empty string.
  String toFormatDate({String? elseText}) {
    return this == null
        ? elseText ?? ''
        : DateFormat('dd.MM.yyyy').format(this!);
  }

  /// Formats the time as `HH:mm` (24-hour clock).
  ///
  /// If this value is `null`, returns [elseText] or an empty string.
  String toFormatTime({String? elseText}) {
    return this == null ? elseText ?? '' : DateFormat('HH:mm').format(this!);
  }

  /// Returns an approximate calendar week number (1-based).
  ///
  /// If this value is `null`, returns `0`.
  ///
  /// Important:
  /// - This is a custom week-number implementation.
  /// - If you require ISO-8601 week numbers, consider using a proven ISO week algorithm
  ///   (edge cases: first/last week of year).
  int toWeekNumber() {
    if (this == null) {
      return 0;
    }

    // Determine the day of the week (1 for Monday, 7 for Sunday)
    final int dayOfWeek = this!.weekday;

    // Calculate the first day of the week (Monday)
    final DateTime firstDayOfWeek = this!.subtract(
      Duration(days: dayOfWeek - 1),
    );

    // Calculate the difference in days as of January 1 of the year
    final int daysSinceEpoch = firstDayOfWeek
        .difference(DateTime(firstDayOfWeek.year, 1, 1))
        .inDays;

    // Calculate the calendar week
    final int weekNumber = (daysSinceEpoch / 7).ceil() + 1;

    return weekNumber;
  }
}
