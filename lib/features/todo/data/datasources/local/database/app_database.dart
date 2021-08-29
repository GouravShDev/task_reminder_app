import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqlite_api.dart' as sqflite;

import '../DAOs/todo_dao.dart';
import '../converters/bool_converter.dart';
import '../converters/date_time_converter.dart';
import '../../../../domain/entities/todo.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter, BoolConverter])
@Database(version: 1, entities: [ToDo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
