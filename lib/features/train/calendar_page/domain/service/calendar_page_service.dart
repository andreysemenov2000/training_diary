import 'package:training_diary/features/train/calendar_page/domain/models/calendar_page_models.dart';

abstract interface class CalendarPageService {
  Future<List<Training>> getTrainingsByDate(DateTime date);
}