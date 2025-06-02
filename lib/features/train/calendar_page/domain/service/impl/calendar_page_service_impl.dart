import 'package:training_diary/features/train/calendar_page/data/gateways/calendar_page_gateway.dart';
import 'package:training_diary/features/train/calendar_page/domain/factory/calendar_page_factory.dart';
import 'package:training_diary/features/train/calendar_page/domain/models/calendar_page_models.dart';
import 'package:training_diary/features/train/calendar_page/domain/service/calendar_page_service.dart';

class CalendarPageServiceImpl implements CalendarPageService {
  final CalendarPageGateway _calendarPageGateway;
  final CalendarPageFactory _calendarPageFactory;

  CalendarPageServiceImpl(this._calendarPageGateway, this._calendarPageFactory);

  @override
  Future<List<Training>> getTrainingsByDate(DateTime date) async {
    final trainingsDbResponse =
        await _calendarPageGateway.getTrainingsByDate(date.toIso8601String());
    return _calendarPageFactory.createTrainingsList(trainingsDbResponse);
  }
}
