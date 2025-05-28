import 'package:flutter/material.dart';

class CalendarThemeExtension extends ThemeExtension<CalendarThemeExtension> {
  final TextStyle monthTextStyle;
  final TextStyle weekDayTextStyle;
  final TextStyle dateTextStyle;
  final Color calendarExpanderColor;

  CalendarThemeExtension({
    this.monthTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    this.weekDayTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    this.dateTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1,
    ),
    this.calendarExpanderColor = Colors.black,
  });

  factory CalendarThemeExtension.light() {
    return CalendarThemeExtension();
  }

  factory CalendarThemeExtension.dark() {
    return CalendarThemeExtension().copyWith(monthTextColor: Colors.pink);
  }

  BoxDecoration getCalendarContainerDecoration(BuildContext context) {
    final theme = Theme.of(context);

    return BoxDecoration(
      color: theme.scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor,
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  BoxDecoration getCalendarDateContainerBoxDecoration(
    BuildContext context, {
    required bool isToday,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    return BoxDecoration(
      border: isToday ? Border.all(color: theme.primaryColor) : null,
      borderRadius: BorderRadius.circular(20),
      color: isSelected ? theme.primaryColor : null,
    );
  }

  TextStyle getCalendarDateTextStyle(
    BuildContext context, {
    required bool isActive,
    required bool isSelected,
  }) {
    Color? color;
    final theme = Theme.of(context);
    if (isSelected) {
      color = theme.scaffoldBackgroundColor;
    }
    if (!isActive) {
      color = Colors.grey;
    }
    return dateTextStyle.copyWith(
      color: color,
    );
  }

  @override
  CalendarThemeExtension copyWith({
    TextStyle? monthTextStyle,
    TextStyle? weekDayTextStyle,
    TextStyle? dateTextStyle,
    Color? monthTextColor,
    Color? weekDayTextColor,
    Color? dateTextColor,
  }) {
    return CalendarThemeExtension(
      monthTextStyle: monthTextStyle ?? this.monthTextStyle.copyWith(color: monthTextColor),
      weekDayTextStyle: weekDayTextStyle ?? this.weekDayTextStyle.copyWith(color: weekDayTextColor),
      dateTextStyle: dateTextStyle ?? this.dateTextStyle.copyWith(color: dateTextColor),
    );
  }

  @override
  ThemeExtension<CalendarThemeExtension> lerp(
    covariant ThemeExtension<CalendarThemeExtension>? other,
    double t,
  ) {
    if (other is! CalendarThemeExtension) {
      return this;
    }

    return CalendarThemeExtension(
      monthTextStyle: TextStyle.lerp(monthTextStyle, other.monthTextStyle, t)!,
      weekDayTextStyle: TextStyle.lerp(weekDayTextStyle, other.weekDayTextStyle, t)!,
      dateTextStyle: TextStyle.lerp(dateTextStyle, other.dateTextStyle, t)!,
    );
  }
}
