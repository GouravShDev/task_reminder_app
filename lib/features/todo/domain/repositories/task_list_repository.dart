// import '';

import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../core/error/failures.dart';

abstract class TaskListRepository {
  Future<Either<Failure, List<TasksList>>> getAllTaskLists();

  Future<Either<Failure, TasksList>> addTaskList(
      TasksListTableCompanion taskList);
}
