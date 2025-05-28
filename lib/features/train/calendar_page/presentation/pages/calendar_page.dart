import 'package:flutter/material.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar/calendar_widget.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/start_train_button_widget.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/train_block_widget.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CalendarWidget(
            onSelectDate: (date) {},
          ),
          const SizedBox(height: 10),
          const TrainBlockWidget(name: 'День ног'),
          const TrainBlockWidget(name: 'День ног'),
        ],
      ),
      floatingActionButton: const StartTrainButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
