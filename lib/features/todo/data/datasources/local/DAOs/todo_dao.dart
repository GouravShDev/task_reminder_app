import 'package:moor/moor.dart';
import '../database/app_database.dart';

part 'todo_dao.g.dart';

@UseDao(tables: [Tasks, TasksListTable])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  final AppDatabase db;

  TodoDao(this.db) : super(db);

  Future<List<Todo>> getAllTodos() => select(tasks).get();
  Stream<List<Todo>> watchAllTodos() => select(tasks).watch();

  Stream<List<TodoWithTasksList>> watchIncompletedWithTaskListTodos() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.due, mode: OrderingMode.desc),
          ])
          ..where((t) => t.isDone.equals(false)))
        .join([
          innerJoin(
              tasksListTable, tasksListTable.id.equalsExp(tasks.tasklistId)),
        ])
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => TodoWithTasksList(
                    todo: row.readTable(tasks),
                    tasksList: row.readTable(tasksListTable)),
              )
              .toList(),
        );
  }

  Stream<List<Todo>> watchCompletedTodos() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.due, mode: OrderingMode.desc),
          ])
          ..where((t) => t.isDone.equals(true)))
        .watch();
  }

  Future<int> insertTodo(Insertable<Todo> todo) =>
      into(tasks).insertOnConflictUpdate(todo);
  Future updateTodo(Insertable<Todo> todo) => update(tasks).replace(todo);
  Future deleteTodo(Insertable<Todo> todo) => delete(tasks).delete(todo);
}
