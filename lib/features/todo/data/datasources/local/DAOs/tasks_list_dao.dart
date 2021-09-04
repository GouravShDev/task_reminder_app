import 'package:moor/moor.dart';

import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

part 'tasks_list_dao.g.dart';

@UseDao(tables: [TasksListTable])
class TasksListDao extends DatabaseAccessor<AppDatabase>
    with _$TasksListDaoMixin {
  final AppDatabase db;
  TasksListDao(this.db) : super(db);

  Stream<List<TasksList>> watchAllTasksList() => select(tasksListTable).watch();
  Future<List<TasksList>> getAllTasksList() => select(tasksListTable).get();
  Future<int> insertTasksList(Insertable<TasksList> tasksList) =>
      into(tasksListTable).insertOnConflictUpdate(tasksList);
  void deleteTaskList(TasksList tasksList) =>
      delete(tasksListTable).delete(tasksList);
}
