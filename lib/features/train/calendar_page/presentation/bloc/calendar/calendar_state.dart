class CalendarState {
  final DateTime selectedDate;
  final bool isWeekRebuild;
  final bool isMonthRebuild;
  final String monthName;
  final List<DateTime> weekDates;
  final List<DateTime> monthDates;

  CalendarState({
    required this.selectedDate,
    required this.monthName,
    required this.weekDates,
    required this.monthDates,
    this.isWeekRebuild = false,
    this.isMonthRebuild = false,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    String? monthName,
    List<DateTime>? weekDates,
    List<DateTime>? monthDates,
    bool? isWeekRebuild,
    bool? isMonthRebuild,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      monthName: monthName ?? this.monthName,
      weekDates: weekDates ?? this.weekDates,
      monthDates: monthDates ?? this.monthDates,
      isWeekRebuild: isWeekRebuild ?? this.isWeekRebuild,
      isMonthRebuild: isMonthRebuild ?? this.isMonthRebuild,
    );
  }
}

class UpdateState extends CalendarState {
  UpdateState({
    required super.selectedDate,
    required super.monthName,
    required super.weekDates,
    required super.monthDates,
  });
}
