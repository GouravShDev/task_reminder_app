import 'package:equatable/equatable.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import '../DAOs/tasks_list_dao.dart';
import 'dart:io';

import '../DAOs/todo_dao.dart';

part 'app_database.g.dart';

//********************************** Tables for the database ************************************/
@DataClassName('Todo')
class Tasks extends Table {
  // autoIncrement automatically sets this to be the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  BoolColumn get isDone => boolean().withDefault(Constant(false))();
  DateTimeColumn get due => dateTime().nullable()();
  BoolColumn get hasAlert => boolean().withDefault(Constant(false))();
  IntColumn get repeatMode => integer().withDefault(Constant(0))();
  IntColumn get tasklistId =>
      integer().withDefault(Constant(0)).customConstraint(
          'DEFAULT 0 REFERENCES tasks_list_table(id) ON DELETE CASCADE')();
}

@DataClassName('TasksList')
class TasksListTable extends Table {
  // autoIncrement automatically sets this to be the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
}

class TodoWithTasksList extends Equatable {
  final Todo todo;
  final TasksList tasksList;

  TodoWithTasksList({
    required this.todo,
    required this.tasksList,
  });

  @override
  List<Object?> get props => [todo, tasksList];
}
//************************************************************************************************/

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Tasks, TasksListTable], daos: [TodoDao, TasksListDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (_) {
          return customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (Migrator m) async {
          await m.createAll();
          into(tasksListTable).insert(TasksListTableCompanion(
            id: Value(0),
            name: Value('Default'),
          ));
          into(tasksListTable).insert(TasksListTableCompanion(
            id: Value(1),
            name: Value('Personal'),
          ));
          into(tasksListTable).insert(TasksListTableCompanion(
            id: Value(2),
            name: Value('Work'),
          ));
        },
      );
}
