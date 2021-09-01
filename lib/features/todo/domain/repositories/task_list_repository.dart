// import '';

import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/domain/entities/task_list.dart';

import '../../../../core/error/failures.dart';

abstract class TaskListRepository {
  Future<Either<Failure, List<TaskList>>> getAllTaskLists();

  Future<Either<Failure, TaskList>> addTaskList(TaskList taskList);
}
