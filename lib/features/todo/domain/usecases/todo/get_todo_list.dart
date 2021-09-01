import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/todo.dart';
import '../../repositories/todos_repository.dart';

class GetTodosList implements UseCase<List<ToDo>, NoParams> {
  final TodosRepository repository;

  GetTodosList(this.repository);

  @override
  Future<Either<Failure, List<ToDo>>> call(NoParams noParams) async {
    final Either<Failure, List<ToDo>> result = await repository.getTodosList();
    return result.fold((failure) => Left(failure), (todos) {
      final List<ToDo> todosList = todos.where((todo) => !todo.isDone).toList();
      return Right(todosList);
    });
    // return result;
  }
}
