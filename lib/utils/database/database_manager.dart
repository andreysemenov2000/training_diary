import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:training_diary/features/train/calendar_page/data/models/calendar_page_models.dart';

class DatabaseManager {
  static const _createDBSQLScript = '''
  CREATE TABLE IF NOT EXISTS muscle_groups (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL UNIQUE
  );

  CREATE TABLE IF NOT EXISTS exercises (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL UNIQUE,
      "isOwnWeight" INTEGER NOT NULL CHECK(isOwnWeight IN (0, 1)),
      "isDoubleWeight" INTEGER NOT NULL CHECK(isDoubleWeight IN (0, 1)),
      "muscle_group" INTEGER NOT NULL,
      FOREIGN KEY("muscle_group") REFERENCES "muscle_groups"("id")
      ON DELETE RESTRICT
  );
  
  CREATE TABLE IF NOT EXISTS templates (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL
  );
  
  CREATE TABLE IF NOT EXISTS comments (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "text" TEXT NOT NULL
  );
  
  CREATE TABLE IF NOT EXISTS sets (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "exercise" INTEGER NOT NULL,
      "reps" INTEGER NOT NULL CHECK(reps > 0),
      "comment" INTEGER,
      "rest_time" INTEGER NOT NULL DEFAULT 0 CHECK(rest_time >= 0),
      "weight" REAL NOT NULL DEFAULT 0 CHECK(weight >= 0),
      "number" INTEGER NOT NULL CHECK(number > 0),
      FOREIGN KEY ("exercise") REFERENCES "exercises"("id") ON DELETE RESTRICT,
      FOREIGN KEY ("comment") REFERENCES "comments"("id") ON DELETE SET NULL
  );
  
  CREATE TABLE IF NOT EXISTS templates_sets (
      "template_id" INTEGER NOT NULL,
      "set_id" INTEGER NOT NULL,
      PRIMARY KEY("template_id", "set_id"),
      FOREIGN KEY ("template_id") REFERENCES "templates"("id") ON DELETE CASCADE,
      FOREIGN KEY ("set_id") REFERENCES "sets"("id") ON DELETE CASCADE
  );
  
  CREATE TABLE IF NOT EXISTS trainings (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "date" TEXT NOT NULL
  );
  
  CREATE TABLE IF NOT EXISTS trainings_sets (
      "training_id" INTEGER NOT NULL,
      "set_id" INTEGER NOT NULL,
      PRIMARY KEY("training_id", "set_id"),
      FOREIGN KEY ("training_id") REFERENCES trainings ("id") ON DELETE CASCADE,
      FOREIGN KEY ("set_id") REFERENCES sets ("id") ON DELETE CASCADE
  );
''';

/*  static const _createDBSQLScript = '''
  BEGIN TRANSACTION;
  
  CREATE TABLE IF NOT EXISTS trainings (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "date" TEXT NOT NULL
  );
  CREATE TABLE IF NOT EXISTS trainings_sets (
      "training_id" INTEGER NOT NULL,
      "set_id" INTEGER NOT NULL,
      PRIMARY KEY("training_id", "set_id"),
      FOREIGN KEY ("training_id") REFERENCES trainings ("id") ON DELETE CASCADE,
      FOREIGN KEY ("set_id") REFERENCES sets ("id") ON DELETE CASCADE
  );
  
  COMMIT;
  ''';*/

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _getOrCreateDB();
    return _database!;
  }

  Future<Database> _getOrCreateDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'training_diary.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    final sqlScripts = _createDBSQLScript.split(';');
    try {
      await db.transaction((trn) async {
        await Future.forEach(sqlScripts, (sqlScript) async {
          await trn.execute(sqlScript);
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTrainings() async {
    final nowIso = DateTime.now().toIso8601String();
    final trainings = List.generate(
      3,
      (i) => TrainingDBQueryModel(date: nowIso, name: 'Тест тренировка $i'),
    );

    // Используем batch для более эффективной вставки
    final db = await database;
    final batch = db.batch();
    for (final training in trainings) {
      batch.insert('trainings', training.toJson());
    }
    await batch.commit();
  }
}
