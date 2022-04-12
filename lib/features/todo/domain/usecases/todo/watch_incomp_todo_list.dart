import 'package:dartz/dartz.dart';
import '../../../data/datasources/local/database/app_database.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/todos_repository.dart';

class WatchIncompTodoList
    implements UseCase<Stream<List<TodoWithTasksList>>, NoParams> {
  final TodosRepository repository;

  WatchIncompTodoList(this.repository);

  @override
  Future<Either<Failure, Stream<List<TodoWithTasksList>>>> call(
      NoParams noParams) async {
    final result = repository.watchIncompTodosList();
    return result.fold((failure) => Left(failure), (stream) {
      // final List<Todo> todosList = todos.where((todo) => !todo.isDone).toList();
      return Right(stream);
    });
    // return result;
  }
}
