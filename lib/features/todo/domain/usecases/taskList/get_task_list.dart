import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/task_list.dart';
import '../../repositories/task_list_repository.dart';

class GetAllTaskList implements UseCase<List<TaskList>, NoParams> {
  final TaskListRepository repository;

  GetAllTaskList(this.repository);

  @override
  Future<Either<Failure, List<TaskList>>> call(NoParams noParams) async {
    final Either<Failure, List<TaskList>> result =
        await repository.getAllTaskLists();
    return result.fold(
        (failure) => Left(failure), (tasklist) => Right(tasklist));
    // return result;
  }
}
