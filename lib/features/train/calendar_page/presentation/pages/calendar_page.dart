import 'package:flutter/material.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CalendarWidget(),
        ],
      ),
    );
  }
}
