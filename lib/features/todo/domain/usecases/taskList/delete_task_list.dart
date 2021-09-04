import 'package:dartz/dartz.dart';
import '../../../data/datasources/local/database/app_database.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/task_list_repository.dart';

class DeleteTaskList implements UseCase<void, TasksListParams> {
  final TaskListRepository repository;

  DeleteTaskList(this.repository);

  @override
  Future<Either<Failure, void>> call(TasksListParams params) async {
    final result = await repository.deleteTaskList(params.tasksList);
    return result.fold(
        (failure) => Left(failure), (tasklist) => Right(tasklist));
    // return result;
  }
}

class TasksListParams {
  final TasksList tasksList;

  TasksListParams(this.tasksList);
}
