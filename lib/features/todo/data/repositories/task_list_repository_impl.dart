import 'package:dartz/dartz.dart';
import '../../domain/entities/task_list.dart';
import '../../domain/repositories/task_list_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/local/todo_database_data_source.dart';

class TaskListRepositoryImpl implements TaskListRepository {
  final TodoDatabaseDataSource databaseDataSource;

  TaskListRepositoryImpl({
    required this.databaseDataSource,
  });

  @override
  Future<Either<Failure, List<TaskList>>> getAllTaskLists() async {
    try {
      return Right(await databaseDataSource.getTaskLists());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, TaskList>> addTaskList(TaskList taskList) async {
    try {
      return Right(await databaseDataSource.storeTaskList(taskList));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
