import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_diary/features/train/calendar_page/domain/service/calendar_page_service.dart';
import 'package:training_diary/features/train/calendar_page/presentation/bloc/calendar_page/calendar_page_state.dart';

class CalendarPageCubit extends Cubit<CalendarPageState> {
  final CalendarPageService _calendarPageService;

  CalendarPageCubit(this._calendarPageService) : super(CalendarPageInitState());

  void loadTrainings(DateTime date) async {
    emit(CalendarPageLoadingState());
    final trainings = await _calendarPageService.getTrainingsByDate(date);
    emit(CalendarPageLoadedState(trainings));
  }
}
