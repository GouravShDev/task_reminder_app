import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../../core/error/exceptions.dart';

abstract class TodoDatabaseDataSource {
  /// Retrieve all [Todo] from the database
  ///
  /// Throws a [DatabaseException] if the database is not available
  Future<List<Todo>> getAllTodos();

  /// Retrieve a Stream of incomplete [TodoWithTasksList] from the database
  ///
  /// Throws a [DatabaseException] if the database is not available
  Stream<List<TodoWithTasksList>> watchIncompTodosAsStream();

  /// Store [Todo] into the database
  /// if already present update it
  ///
  /// Throws a [DatabaseException] if unable to store the data
  Future<int> storeTodo(TasksCompanion todo);

  /// Retieve all [Tasks List] from the database
  ///
  /// Throws a [DatabaseException] if the database is not available
  Future<List<TasksList>> getAllTaskLists();

  /// Store [Task List] into the database
  ///
  /// Throws a [DatabaseException] if unable to store the data
  Future<int> storeTasksList(TasksListTableCompanion taskList);

  /// Delete [Task List] from the database
  ///
  /// Throws a [DatabaseException] if unable to store the data
  void deleteTasksList(TasksList taskList);

  /// Retrieve a Stream of [TasksList] from the database
  ///
  /// Throws a [DatabaseException] if the database is not available
  Stream<List<TasksList>> watchTaskListsAsStream();
}

class TodoDatabaseSourceImpl extends TodoDatabaseDataSource {
  final AppDatabase _appDatabase;

  TodoDatabaseSourceImpl(this._appDatabase);

  @override
  Future<List<TasksList>> getAllTaskLists() {
    return _appDatabase.tasksListDao.getAllTasksList();
  }

  @override
  Future<List<Todo>> getAllTodos() {
    return _appDatabase.todoDao.getAllTodos();
  }

  @override
  Future<int> storeTasksList(TasksListTableCompanion taskList) {
    return _appDatabase.tasksListDao.insertTasksList(taskList);
  }

  @override
  Future<int> storeTodo(TasksCompanion todo) {
    return _appDatabase.todoDao.insertTodo(todo);
  }

  @override
  Stream<List<TodoWithTasksList>> watchIncompTodosAsStream() {
    return _appDatabase.todoDao.watchIncompletedWithTaskListTodos();
  }

  @override
  Stream<List<TasksList>> watchTaskListsAsStream() {
    return _appDatabase.tasksListDao.watchAllTasksList();
  }

  @override
  void deleteTasksList(TasksList taskList) {
    return _appDatabase.tasksListDao.deleteTaskList(taskList);
  }
}
