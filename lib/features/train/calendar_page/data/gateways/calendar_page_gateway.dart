import 'package:training_diary/features/train/calendar_page/data/models/calendar_page_models.dart';

abstract interface class CalendarPageGateway {
  Future<void> createTraining();
  Future<List<TrainingDBResponseModel>> getTrainingsByDate(String date);
}
