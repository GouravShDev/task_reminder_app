import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../datasources/local/todo_database_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todos_repository.dart';

class TodoRepositoryImpl implements TodosRepository {
  final TodoDatabaseDataSource databaseDataSource;

  TodoRepositoryImpl({
    required this.databaseDataSource,
  });

  @override
  Future<Either<Failure, List<ToDo>>> getTodosList() async {
    try {
      return Right(await databaseDataSource.getTodosList());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, ToDo>> addTodo(ToDo todo) async {
    try {
      return Right(await databaseDataSource.storeToDo(todo));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
