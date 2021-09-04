import 'package:dartz/dartz.dart';
import '../../../data/datasources/local/database/app_database.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/task_list_repository.dart';

class WatchTasksList implements UseCase<Stream<List<TasksList>>, NoParams> {
  final TaskListRepository repository;

  WatchTasksList(this.repository);

  @override
  Future<Either<Failure, Stream<List<TasksList>>>> call(
      NoParams noParams) async {
    final result = repository.watchAllTaskLists();
    return result.fold((failure) => Left(failure), (stream) => Right(stream));
    // return result;
  }
}
