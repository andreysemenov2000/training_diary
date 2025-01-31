import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar/calendar_state.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar_cubit.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar/month_widget.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar/week_widget.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_constants.dart';
import 'package:training_diary/utils/themes/text_theme.dart';

class CalendarWidget extends StatelessWidget {
  final void Function(DateTime) onSelectDate;

  const CalendarWidget({required this.onSelectDate, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarCubit(),
      child: CalendarWidgetFlow(onSelectDate: onSelectDate),
    );
  }
}

class CalendarWidgetFlow extends StatefulWidget {
  final void Function(DateTime) onSelectDate;

  const CalendarWidgetFlow({required this.onSelectDate, super.key});

  @override
  State<CalendarWidgetFlow> createState() => _CalendarWidgetFlowState();
}

class _CalendarWidgetFlowState extends State<CalendarWidgetFlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _weekOpacity;
  late final Animation<double> _monthOpacity;
  late double _calendarColumnsSpacing;
  double _calendarHeight = minCalendarHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: opacityDuration);
    _weekOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.8),
      ),
    );
    _monthOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calendarTextThemeExtension = theme.extension<CalendarTextThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 13,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
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
      ),
      child: Column(
        children: [
          _buildMonthName(calendarTextThemeExtension),
          _buildDaysOfWeek(),
          AnimatedContainer(
            onEnd: _onEndAnimation,
            duration: expandingDuration,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
            height: _calendarHeight,
            child: _buildWeekMonth(context),
          ),
          _buildCalendarExpander(),
        ],
      ),
    );
  }

  Widget _buildMonthName(CalendarTextThemeExtension calendarTextThemeExtension) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (prev, cur) => prev.monthName != cur.monthName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            children: [
              Text(
                state.monthName,
                style: calendarTextThemeExtension.monthTextStyle,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDaysOfWeek() {
    final theme = Theme.of(context);
    final calendarTextThemeExtension = theme.extension<CalendarTextThemeExtension>()!;
    final spacing = MediaQuery.sizeOf(context).width / 12.2;
    final List<Widget> widgets = [];
    for (int i = 0; i < numberDaysWeek; i++) {
      widgets.add(
        Padding(
          padding: i != numberDaysWeek - 1 ? EdgeInsets.only(right: spacing) : EdgeInsets.zero,
          child: Text(
            daysOfWeek[i],
            style: calendarTextThemeExtension.weekDayTextStyle,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Row(children: widgets),
    );
  }

  void _onEndAnimation() {
    if (_calendarHeight == maxCalendarHeight) {
      BlocProvider.of<CalendarCubit>(context).rebuildMonthName(isMonthNow: true);
    } else {
      BlocProvider.of<CalendarCubit>(context).rebuildMonthName(isMonthNow: false);
    }
  }

  Widget _buildWeekMonth(BuildContext context) {
    _calendarColumnsSpacing = MediaQuery.sizeOf(context).width / 18.9;
    return Stack(
      children: [
        WeekWidget(
          controller: _controller,
          calendarColumnsSpacing: _calendarColumnsSpacing,
          weekOpacity: _weekOpacity,
        ),
        MonthWidget(
          controller: _controller,
          calendarColumnsSpacing: _calendarColumnsSpacing,
          monthOpacity: _monthOpacity,
        ),
      ],
    );
  }

  Widget _buildCalendarExpander() {
    return GestureDetector(
      onVerticalDragUpdate: _onDraggingExpander,
      onVerticalDragEnd: _onEndDraggingExpander,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: 50,
          height: 3,
          color: Colors.green,
        ),
      ),
    );
  }

  void _onDraggingExpander(DragUpdateDetails details) {
    final dy = details.delta.dy;
    bool isExpanding = false;
    if (dy < 0) {
      isExpanding = false;
    } else if (dy > 0) {
      isExpanding = true;
    }
    setState(() {
      _calendarHeight += dy;

      if (_calendarHeight > autoExpandingHeight && isExpanding) {
        _calendarHeight = maxCalendarHeight;
        _showMonthWeek(isShowMonth: true);
      } else if (_calendarHeight < autoCollapsingHeight && !isExpanding) {
        _calendarHeight = minCalendarHeight;
        _showMonthWeek();
      }
    });
  }

  void _onEndDraggingExpander(DragEndDetails details) {
    if (_calendarHeight <= autoExpandingHeight && _calendarHeight != minCalendarHeight) {
      setState(() {
        _calendarHeight = minCalendarHeight;
      });
    } else if (_calendarHeight >= autoCollapsingHeight && _calendarHeight != maxCalendarHeight) {
      setState(() {
        _calendarHeight = maxCalendarHeight;
      });
    }
  }

  void _showMonthWeek({bool isShowMonth = false}) {
    if (!isShowMonth) {
      _controller.reverse();
    } else if (isShowMonth) {
      _controller.forward();
    }
  }
}
