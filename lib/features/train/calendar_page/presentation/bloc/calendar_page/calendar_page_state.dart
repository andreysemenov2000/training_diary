import 'package:training_diary/features/train/calendar_page/domain/models/calendar_page_models.dart';

sealed class CalendarPageState {}

class CalendarPageInitState extends CalendarPageState {}

class CalendarPageLoadingState extends CalendarPageState {}

class CalendarPageLoadedState extends CalendarPageState {
  final List<Training> trainings;

  CalendarPageLoadedState(this.trainings);
}