import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
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
  Future<Either<Failure, List<TasksList>>> getAllTaskLists() async {
    try {
      return Right(await databaseDataSource.getAllTaskLists());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, TasksList>> addTaskList(
      TasksListTableCompanion taskList) async {
    try {
      return Right(await databaseDataSource.storeTasksList(taskList));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
