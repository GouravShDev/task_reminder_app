import 'package:dartz/dartz.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/todos_repository.dart';

class GetTodosList implements UseCase<List<Todo>, NoParams> {
  final TodosRepository repository;

  GetTodosList(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams noParams) async {
    final Either<Failure, List<Todo>> result = await repository.getTodosList();
    return result.fold((failure) => Left(failure), (todos) {
      final List<Todo> todosList = todos.where((todo) => !todo.isDone).toList();
      return Right(todosList);
    });
    // return result;
  }
}
