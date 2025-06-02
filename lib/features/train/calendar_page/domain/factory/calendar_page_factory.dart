import 'package:training_diary/features/train/calendar_page/data/models/calendar_page_models.dart';
import 'package:training_diary/features/train/calendar_page/domain/models/calendar_page_models.dart';

abstract interface class CalendarPageFactory {
  List<Training> createTrainingsList(List<TrainingDBResponseModel> trainingsDbResponse);
}