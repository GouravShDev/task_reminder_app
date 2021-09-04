import 'package:dartz/dartz.dart';
import '../datasources/local/database/app_database.dart';
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
  Future<Either<Failure, int>> addTaskList(
      TasksListTableCompanion taskList) async {
    try {
      return Right(await databaseDataSource.storeTasksList(taskList));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Either<Failure, Stream<List<TasksList>>> watchAllTaskLists() {
    try {
      return Right(databaseDataSource.watchTaskListsAsStream());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Either<Failure, void> deleteTaskList(TasksList tasksList) {
    try {
      return Right(databaseDataSource.deleteTasksList(tasksList));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
