import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/task_list_repository.dart';

class GetAllTaskList implements UseCase<List<TasksList>, NoParams> {
  final TaskListRepository repository;

  GetAllTaskList(this.repository);

  @override
  Future<Either<Failure, List<TasksList>>> call(NoParams noParams) async {
    final Either<Failure, List<TasksList>> result =
        await repository.getAllTaskLists();
    return result.fold(
        (failure) => Left(failure), (tasklist) => Right(tasklist));
    // return result;
  }
}
