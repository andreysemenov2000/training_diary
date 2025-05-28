import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar/calendar_state.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar_cubit.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar/swipe_detector_widget.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_constants.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_utils.dart';

class MonthWidget extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> monthOpacity;
  final double calendarColumnsSpacing;

  const MonthWidget({
    required this.controller,
    required this.monthOpacity,
    required this.calendarColumnsSpacing,
    super.key,
  });

  @override
  State<MonthWidget> createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  late final PageController _monthPageController;
  bool _offstage = true;

  @override
  void initState() {
    _monthPageController = PageController(initialPage: pageControllerInitialPage);
    widget.monthOpacity.addListener(_updateOffstage);
    super.initState();
  }

  void _updateOffstage() {
    final newOffstage = widget.monthOpacity.value == 0;
    if (newOffstage != _offstage) {
      setState(() {
        _offstage = newOffstage;
      });
    }
  }

  @override
  void dispose() {
    _monthPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _offstage,
      child: SwipeDetectorWidget(
        onSwipe: _onSwipe,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _monthPageController,
          itemBuilder: (context, i) {
            final calendarCubit = BlocProvider.of<CalendarCubit>(context);
            calendarCubit.changeMonth(i - pageControllerInitialPage);
            return AnimatedBuilder(
              animation: widget.controller.view,
              builder: (context, child) => Opacity(
                opacity: widget.monthOpacity.value,
                child: child,
              ),
              child: BlocBuilder<CalendarCubit, CalendarState>(
                buildWhen: (prev, cur) => cur.isMonthRebuild,
                builder: (context, state) {
                  return Wrap(
                    spacing: widget.calendarColumnsSpacing,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: buildCalendarColumns(
                      context,
                      dates: calendarCubit.state.monthDates,
                      onDateSelect: (date) => calendarCubit.selectDate(date, isMonthNow: true),
                      selectedDate: calendarCubit.state.selectedDate,
                      currentMonth: calendarCubit.currentMonth,
                      isMonth: true,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSwipe({required bool isSwipeToLeft}) {
    if (isSwipeToLeft) {
      unawaited(_monthPageController.nextPage(duration: swipeDuration, curve: Curves.easeOut));
    } else {
      unawaited(_monthPageController.previousPage(duration: swipeDuration, curve: Curves.easeOut));
    }
  }
}
