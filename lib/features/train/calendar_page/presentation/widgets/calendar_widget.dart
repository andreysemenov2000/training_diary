import 'package:flutter/material.dart';
import 'package:training_diary/utils/themes/text_theme.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> with SingleTickerProviderStateMixin {
  static const List<String> _daysOfWeek = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
  static const _numberDaysWeek = 7;
  static const _minCalendarHeight = 80.0;
  static const _maxCalendarHeight = 240.0;
  static const _opacityDuration = Duration(milliseconds: 150);

  late final AnimationController _controller;
  late final Animation<double> _monthOpacity;
  late double _calendarColumnsSpacing;
  DateTime _selectedDate = DateTime.now();
  double _calendarHeight = _minCalendarHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _opacityDuration);
    _monthOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1),
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
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
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Row(
        children: [
          Text(
            'Август',
            style: calendarTextThemeExtension.monthTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildWeekMonth(BuildContext context) {
    _calendarColumnsSpacing = MediaQuery.sizeOf(context).width / 18.9;
    return Stack(
      children: [
        _buildWeek(context),
        _buildMonth(context),
      ],
    );
  }

  Widget _buildWeek(BuildContext context) {
    return Wrap(
      spacing: _calendarColumnsSpacing,
      children: _buildCalendarColumns(context),
    );
  }

  Widget _buildMonth(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) => Opacity(
        opacity: _monthOpacity.value,
        child: child,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 68),
        child: Wrap(
          spacing: _calendarColumnsSpacing,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.spaceBetween,
          children: _buildCalendarColumns(context, isMonth: true),
        ),
      ),
    );
  }

  List<Widget> _buildCalendarColumns(BuildContext context, {bool isMonth = false}) {
    final theme = Theme.of(context);
    final calendarTextThemeExtension = theme.extension<CalendarTextThemeExtension>()!;
    final List<Widget> columns = [];
    final List<DateTime> datesOfWeek = _getListDates(isMonth: isMonth);

    for (int i = 0; i < _numberDaysWeek; i++) {
      final List<Widget> children = [];
      if (!isMonth) {
        children.add(
          Text(
            _daysOfWeek[i],
            style: calendarTextThemeExtension.weekDayTextStyle,
          ),
        );
      }
      int j = i;
      while (j < datesOfWeek.length) {
        children.add(
          _buildCalendarDate(
            dateOfWeek: datesOfWeek[j],
            theme: theme,
            calendarTextThemeExtension: calendarTextThemeExtension,
          ),
        );
        j += _numberDaysWeek;
      }
      columns.add(
        Column(
          children: children,
        ),
      );
    }
    return columns;
  }

  List<DateTime> _getListDates({required bool isMonth}) {
    final List<DateTime> dates = [];
    final int numberOfWeeks = isMonth ? 4 : 1;
    final now = DateTime.now();
    var weekStart = now.subtract(Duration(days: now.weekday - 1));
    if (isMonth) {
      weekStart = weekStart.add(const Duration(days: 7));
    }
    for (int i = 0; i < _numberDaysWeek * numberOfWeeks; i++) {
      dates.add(weekStart);
      weekStart = weekStart.add(const Duration(days: 1));
    }
    return dates;
  }

  Widget _buildCalendarDate({
    required DateTime dateOfWeek,
    required ThemeData theme,
    required CalendarTextThemeExtension calendarTextThemeExtension,
  }) {
    final bool isToday = _checkIsSameDay(dateOfWeek, DateTime.now());
    final bool isSelected = _checkIsSameDay(dateOfWeek, _selectedDate);
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDate = dateOfWeek;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: isToday ? Border.all(color: theme.primaryColor) : null,
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? theme.primaryColor : null,
        ),
        child: Center(
          child: Text(
            '${dateOfWeek.day}',
            style: calendarTextThemeExtension.dateTextStyle
                .copyWith(color: isSelected ? theme.scaffoldBackgroundColor : null),
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
    return date.day == otherDate.day &&
        date.month == otherDate.month &&
        date.year == otherDate.year;
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
    setState(() {
      _calendarHeight += dy;
      if (_calendarHeight >= _maxCalendarHeight / 2) {
        _showMonthWeek(isShowMonth: true);
      } else {
        _showMonthWeek();
      }

      if (_calendarHeight > _maxCalendarHeight) {
        _calendarHeight = _maxCalendarHeight;
      } else if (_calendarHeight < _minCalendarHeight) {
        _calendarHeight = _minCalendarHeight;
      }
    });
  }

  void _onEndDraggingExpander(DragEndDetails details) {
    setState(() {
      if (_calendarHeight >= _maxCalendarHeight - 100) {
        _calendarHeight = _maxCalendarHeight;
      } else {
        _calendarHeight = _minCalendarHeight;
      }
    });
  }

  void _showMonthWeek({bool isShowMonth = false}) {
    if (!isShowMonth) {
      _controller.reverse();
    } else if (isShowMonth) {
      _controller.forward();
    }
  }
}
