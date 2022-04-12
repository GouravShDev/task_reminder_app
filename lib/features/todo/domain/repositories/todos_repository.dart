// import '';

import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../core/error/failures.dart';

abstract class TodosRepository {
  Future<Either<Failure, List<Todo>>> getTodosList();

  Either<Failure, Stream<List<TodoWithTasksList>>> watchIncompTodosList();

  Future<Either<Failure, int>> addTodo(TasksCompanion todo);
}
