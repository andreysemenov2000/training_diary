import 'package:flutter/material.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_constants.dart';
import 'package:training_diary/utils/themes/extensions/calendar_theme_extension.dart';

DateTime getWeekMonday(DateTime startDate) {
  return startDate.subtract(Duration(days: startDate.weekday - 1));
}

DateTime getMonthMonday(DateTime startDate) {
  final monthStart = DateTime(startDate.year, startDate.month);
  return monthStart.subtract(Duration(days: monthStart.weekday - 1));
}

List<DateTime> getListDates({
  required DateTime start,
  bool isMonth = false,
  int currentMonth = -1,
}) {
  final List<DateTime> dates = [];
  DateTime date = start;
  for (int i = 0; i < numberDaysWeek; i++) {
    dates.add(date);
    date = date.add(const Duration(days: 1));
  }
  if (isMonth) {
    int weekDaysCount = 0;
    while (date.month == currentMonth || weekDaysCount % numberDaysWeek != 0) {
      dates.add(date);
      date = date.add(const Duration(days: 1));
      weekDaysCount++;
    }
  }
  return dates;
}

List<Widget> buildCalendarColumns(
  BuildContext context, {
  required List<DateTime> dates,
  required void Function(DateTime date) onDateSelect,
  required DateTime selectedDate,
  int currentMonth = -1,
  bool isMonth = false,
}) {
  final List<Widget> columns = [];

  for (int i = 0; i < numberDaysWeek; i++) {
    final List<Widget> children = [];
    int j = i;
    while (j < dates.length) {
      children.add(
        _buildCalendarDate(
          context,
          date: dates[j],
          onDateSelect: onDateSelect,
          selectedDate: selectedDate,
          currentMonth: currentMonth,
          isMonth: isMonth,
        ),
      );
      j += numberDaysWeek;
    }
    columns.add(
      Column(
        children: children,
      ),
    );
  }
  return columns;
}

Widget _buildCalendarDate(
  BuildContext context, {
  required DateTime date,
  required void Function(DateTime date) onDateSelect,
  required DateTime selectedDate,
  required int currentMonth,
  required bool isMonth,
}) {
  final theme = Theme.of(context);
  final calendarThemeExtension = theme.extension<CalendarThemeExtension>()!;
  final now = DateTime.now();
  final bool isToday = _checkIsSameDay(date, now);
  final bool isSelected = _checkIsSameDay(date, selectedDate);
  final bool isActive = _checkIsActive(
    isMonth: isMonth,
    dateMonth: date.month,
    currentMonth: currentMonth,
  );

  return InkWell(
    onTap: () {
      if (!isSelected) {
        onDateSelect(date);
      }
    },
    child: Container(
      margin: const EdgeInsets.only(top: 5),
      width: 34,
      height: 34,
      decoration: calendarThemeExtension.getCalendarDateContainerBoxDecoration(
        context,
        isToday: isToday,
        isSelected: isSelected,
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: calendarThemeExtension.getCalendarDateTextStyle(
            context,
            isActive: isActive,
            isSelected: isSelected,
          ),
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToLastDescent: false,
            applyHeightToFirstAscent: false,
          ),
        ),
      ),
    ),
  );
}

bool _checkIsSameDay(DateTime date, DateTime otherDate) {
  return date.day == otherDate.day && date.month == otherDate.month && date.year == otherDate.year;
}

bool _checkIsActive({
  required bool isMonth,
  required int dateMonth,
  required int currentMonth,
}) {
  if (isMonth) {
    return dateMonth == currentMonth;
  } else {
    return true;
  }
}
