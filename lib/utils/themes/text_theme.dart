import 'package:flutter/material.dart';

TextTheme createTextTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
  );
}

class CalendarTextThemeExtension extends ThemeExtension<CalendarTextThemeExtension> {
  final TextStyle monthTextStyle;
  final TextStyle weekDayTextStyle;
  final TextStyle dateTextStyle;

  CalendarTextThemeExtension({
    required this.monthTextStyle,
    required this.weekDayTextStyle,
    required this.dateTextStyle,
  });

  factory CalendarTextThemeExtension.light() {
    return CalendarTextThemeExtension(
      monthTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      weekDayTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,
      ),
      dateTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1,
      ),
    );
  }

  factory CalendarTextThemeExtension.dark() {
    return CalendarTextThemeExtension(
      monthTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      weekDayTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
      dateTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1,
      ),
    );
  }

  @override
  ThemeExtension<CalendarTextThemeExtension> copyWith({
    TextStyle? monthTextStyle,
    TextStyle? weekDayTextStyle,
    TextStyle? dateTextStyle,
  }) {
    assert(
      monthTextStyle != null || weekDayTextStyle != null || dateTextStyle != null,
      'All parameters are null',
    );
    return CalendarTextThemeExtension(
      monthTextStyle: monthTextStyle ?? this.monthTextStyle,
      weekDayTextStyle: weekDayTextStyle ?? this.weekDayTextStyle,
      dateTextStyle: dateTextStyle ?? this.dateTextStyle,
    );
  }

  @override
  ThemeExtension<CalendarTextThemeExtension> lerp(
    covariant ThemeExtension<CalendarTextThemeExtension>? other,
    double t,
  ) {
    if (other is! CalendarTextThemeExtension) {
      return this;
    }

    return CalendarTextThemeExtension(
      monthTextStyle: TextStyle.lerp(monthTextStyle, other.monthTextStyle, t)!,
      weekDayTextStyle: TextStyle.lerp(weekDayTextStyle, other.weekDayTextStyle, t)!,
      dateTextStyle: TextStyle.lerp(dateTextStyle, other.dateTextStyle, t)!,
    );
  }
}
