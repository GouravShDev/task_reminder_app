// import '';

import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../core/error/failures.dart';

abstract class TaskListRepository {
  Future<Either<Failure, List<TasksList>>> getAllTaskLists();
  Either<Failure, Stream<List<TasksList>>> watchAllTaskLists();

  Future<Either<Failure, int>> addTaskList(TasksListTableCompanion taskList);

  Either<Failure, void> deleteTaskList(TasksList tasksList);
}
