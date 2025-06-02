import 'package:training_diary/features/train/calendar_page/data/models/calendar_page_models.dart';
import 'package:training_diary/features/train/calendar_page/domain/factory/calendar_page_factory.dart';
import 'package:training_diary/features/train/calendar_page/domain/models/calendar_page_models.dart';

class CalendarPageFactoryImpl implements CalendarPageFactory {
  @override
  List<Training> createTrainingsList(List<TrainingDBResponseModel> trainingsDbResponses) {
    return trainingsDbResponses
        .map(
          (t) => Training(
            id: t.id,
            name: t.name,
            date: DateTime.parse(t.date),
          ),
        )
        .toList();
  }
}
