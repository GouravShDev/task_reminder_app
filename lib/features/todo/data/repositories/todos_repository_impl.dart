import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/todos_repository.dart';
import '../datasources/local/todo_database_data_source.dart';

class TodoRepositoryImpl implements TodosRepository {
  final TodoDatabaseDataSource databaseDataSource;

  TodoRepositoryImpl({
    required this.databaseDataSource,
  });

  @override
  Future<Either<Failure, List<Todo>>> getTodosList() async {
    try {
      return Right(await databaseDataSource.getAllTodos());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addTodo(TasksCompanion todo) async {
    try {
      return Right(await databaseDataSource.storeTodo(todo));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Either<Failure, Stream<List<TodoWithTasksList>>> watchIncompTodosList() {
    try {
      return Right(databaseDataSource.watchIncompTodosAsStream());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
