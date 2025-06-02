import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar/calendar_state.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar/calendar_cubit.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar/swipe_detector_widget.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_constants.dart';
import 'package:training_diary/features/train/calendar_page/utils/calendar_utils.dart';

class WeekWidget extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> weekOpacity;
  final double calendarColumnsSpacing;
  final void Function(DateTime date) onSelectDate;

  const WeekWidget({
    required this.controller,
    required this.calendarColumnsSpacing,
    required this.weekOpacity,
    required this.onSelectDate,
    super.key,
  });

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  late final PageController _weekPageController;
  bool _offstage = false;

  @override
  void initState() {
    super.initState();
    _weekPageController = PageController(initialPage: pageControllerInitialPage);
    widget.weekOpacity.addListener(_updateOffstage);
  }

  void _updateOffstage() {
    final newOffstage = widget.weekOpacity.value == 0;
    if (newOffstage != _offstage) {
      setState(() {
        _offstage = newOffstage;
      });
    }
  }

  @override
  void dispose() {
    _weekPageController.dispose();
    widget.weekOpacity.removeListener(_updateOffstage);
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
          controller: _weekPageController,
          itemBuilder: (context, i) {
            final calendarCubit = BlocProvider.of<CalendarCubit>(context);
            calendarCubit.changeWeek(i - pageControllerInitialPage);
            return AnimatedBuilder(
              animation: widget.controller.view,
              builder: (context, child) => Opacity(
                opacity: widget.weekOpacity.value,
                child: child,
              ),
              child: BlocBuilder<CalendarCubit, CalendarState>(
                buildWhen: (prev, cur) => cur.isWeekRebuild,
                builder: (context, state) {
                  return Wrap(
                    spacing: widget.calendarColumnsSpacing,
                    children: buildCalendarColumns(
                      context,
                      dates: calendarCubit.state.weekDates,
                      onDateSelect: (date) {
                        widget.onSelectDate(date);
                        calendarCubit.selectDate(date, isMonthNow: false);
                      },
                      selectedDate: calendarCubit.state.selectedDate,
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
      unawaited(_weekPageController.nextPage(duration: swipeDuration, curve: Curves.easeOut));
    } else {
      unawaited(_weekPageController.previousPage(duration: swipeDuration, curve: Curves.easeOut));
    }
  }
}
