import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_diary/features/train/calendar_page/domain/service/calendar_page_service.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar_page/calendar_page_cubit.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar_page/calendar_page_state.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/calendar/calendar_widget.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/start_train_button_widget.dart';
import 'package:training_diary/features/train/calendar_page/presentation/widgets/train_block_widget.dart';
import 'package:training_diary/utils/dependency_manager.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarPageCubit>(
      create: (context) =>
          CalendarPageCubit(getIt<CalendarPageService>())..loadTrainings(DateTime.now()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: [
                CalendarWidget(
                  onSelectDate: (date) {
                    BlocProvider.of<CalendarPageCubit>(context).loadTrainings(date);
                  },
                ),
                const SizedBox(height: 10),
                _buildTrainingBlocks(),
              ],
            ),
            floatingActionButton: const StartTrainButtonWidget(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget _buildTrainingBlocks() {
    return Expanded(
      child: BlocBuilder<CalendarPageCubit, CalendarPageState>(
        builder: (context, state) {
          if (state is CalendarPageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CalendarPageLoadedState) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.trainings.length,
              itemBuilder: (context, i) => TrainBlockWidget(
                id: state.trainings[i].id,
                name: state.trainings[i].name,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
