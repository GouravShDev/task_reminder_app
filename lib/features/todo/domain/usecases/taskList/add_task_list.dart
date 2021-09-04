import 'package:dartz/dartz.dart';
import '../../../data/datasources/local/database/app_database.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/task_list_repository.dart';

class AddTaskList implements UseCase<int, TasksListCompParams> {
  final TaskListRepository repository;

  AddTaskList(this.repository);

  @override
  Future<Either<Failure, int>> call(TasksListCompParams params) async {
    final result = await repository.addTaskList(params.taskList);
    return result.fold(
        (failure) => Left(failure), (tasklist) => Right(tasklist));
    // return result;
  }
}

class TasksListCompParams {
  final TasksListTableCompanion taskList;

  TasksListCompParams(this.taskList);
}
