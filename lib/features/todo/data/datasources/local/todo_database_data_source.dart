import 'database/app_database.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/todo.dart';

abstract class TodoDatabaseDataSource {
  /// Retrieve all [ToDo] from the database
  ///
  /// Throws a [DatabaseException] if the database is not available
  Future<List<ToDo>> getTodosList();

  /// Store [ToDo] into the database
  ///
  /// Throws a [DatabaseException] if unable to store the data
  Future<ToDo> storeToDo(ToDo todo);
}

class TodoDatabaseSourceImpl extends TodoDatabaseDataSource {
  final AppDatabase _appDatabase;

  TodoDatabaseSourceImpl(this._appDatabase);

  @override
  Future<List<ToDo>> getTodosList() async {
    return await _appDatabase.todoDao.getAllTodos();
  }

  @override
  Future<ToDo> storeToDo(ToDo todo) async {
    final id = await _appDatabase.todoDao.insertTodo(todo);
    return ToDo(
      id: id,
      name: todo.name,
      due: todo.due,
      isDone: todo.isDone,
      hasAlert: todo.hasAlert,
    );
  }
}
