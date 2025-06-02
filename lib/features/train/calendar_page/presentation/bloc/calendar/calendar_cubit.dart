import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar/calendar_state.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_constants.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_utils.dart';

class CalendarCubit extends Cubit<CalendarState> {
  DateTime _weekMonday = getWeekMonday(DateTime.now());
  DateTime _monthMonday = getMonthMonday(DateTime.now());
  int currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;
  int _lastMonthIndex = 0;
  int _lastWeekIndex = 0;

  CalendarCubit()
      : super(
          CalendarState(
            selectedDate: DateTime.now(),
            monthName: monthNames[DateTime.now().month - 1],
            weekDates: getListDates(start: getWeekMonday(DateTime.now())),
            monthDates: getListDates(
              start: getMonthMonday(DateTime.now()),
              isMonth: true,
              currentMonth: DateTime.now().month,
            ),
          ),
        );

  void selectDate(DateTime date, {required bool isMonthNow}) {
    List<DateTime>? weekDates;
    if (isMonthNow) {
      final newWeekMonday = getWeekMonday(date);
      if (_weekMonday != newWeekMonday) {
        _weekMonday = newWeekMonday;
        weekDates = getListDates(start: _weekMonday);
      }
    }
    emit(
      state.copyWith(
        selectedDate: date,
        weekDates: weekDates,
        isWeekRebuild: true,
        isMonthRebuild: true,
      ),
    );
  }

  void changeMonth(int monthIndex) {
    if (monthIndex != _lastMonthIndex) {
      if (monthIndex < _lastMonthIndex) {
        currentMonth--;
      } else if (monthIndex > _lastMonthIndex) {
        currentMonth++;
      }
      if (currentMonth < 1) {
        currentMonth = 12;
        _currentYear--;
      } else if (currentMonth > 12) {
        currentMonth = 1;
        _currentYear++;
      }

      _monthMonday = getMonthMonday(DateTime(_currentYear, currentMonth));
      final List<DateTime> monthDates = getListDates(
        start: _monthMonday,
        isMonth: true,
        currentMonth: currentMonth,
      );

      if (state.selectedDate.month == currentMonth) {
        _weekMonday = getWeekMonday(state.selectedDate);
      } else {
        _weekMonday = _monthMonday;
      }
      final List<DateTime> weekDates = getListDates(start: _weekMonday);
      _lastMonthIndex = monthIndex;

      emit(
        state.copyWith(
          monthDates: monthDates,
          weekDates: weekDates,
          isWeekRebuild: true,
          isMonthRebuild: false,
          monthName: _getMonthName(isMonthNow: true),
        ),
      );
    }
  }

  String _getMonthName({required bool isMonthNow}) {
    return monthNames[(isMonthNow ? currentMonth : _weekMonday.month) - 1];
  }

  void changeWeek(int weekIndex) {
    const sevenDays = Duration(days: 7);
    if (weekIndex != _lastWeekIndex) {
      if (weekIndex < _lastWeekIndex) {
        _weekMonday = _weekMonday.subtract(sevenDays);
      } else if (weekIndex > _lastWeekIndex) {
        _weekMonday = _weekMonday.add(sevenDays);
      }
      _lastWeekIndex = weekIndex;
      final List<DateTime> weekDates = getListDates(start: _weekMonday);
      CalendarState newState = state.copyWith(
        weekDates: weekDates,
        isWeekRebuild: false,
      );

      if (_weekMonday.month != currentMonth) {
        currentMonth = _weekMonday.month;
        _monthMonday = getMonthMonday(DateTime(_currentYear, currentMonth));
        final List<DateTime> monthDates = getListDates(
          start: _monthMonday,
          isMonth: true,
          currentMonth: currentMonth,
        );
        newState = newState.copyWith(
          monthName: _getMonthName(isMonthNow: false),
          monthDates: monthDates,
          isMonthRebuild: true,
        );
      }

      emit(newState);
    }
  }

  void rebuildMonthName({required bool isMonthNow}) {
    final monthName = _getMonthName(isMonthNow: isMonthNow);
    emit(state.copyWith(monthName: monthName));
  }
}
