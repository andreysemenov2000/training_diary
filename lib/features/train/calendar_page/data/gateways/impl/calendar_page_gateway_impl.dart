import 'package:training_diary/features/train/calendar_page/data/gateways/calendar_page_gateway.dart';
import 'package:training_diary/features/train/calendar_page/data/models/calendar_page_models.dart';
import 'package:training_diary/utils/database/database_manager.dart';

class CalendarPageGatewayImpl implements CalendarPageGateway {
  final DatabaseManager _databaseManager;

  CalendarPageGatewayImpl(this._databaseManager);

  @override
  Future<void> createTraining() async {
    final db = await _databaseManager.database;
    final nowIso = DateTime.now().toIso8601String();
    final training = TrainingDBQueryModel(date: nowIso, name: 'Тест тренировка 1');
    await db.insert('trainings', training.toJson());
  }

  @override
  Future<List<TrainingDBResponseModel>> getTrainingsByDate(String date) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> json = await db.query(
      'trainings',
      where: 'DATE(date) = DATE(?)',
      whereArgs: [date],
    );
    return List.generate(json.length, (i) => TrainingDBResponseModel.fromJson(json[i]));
  }
}
