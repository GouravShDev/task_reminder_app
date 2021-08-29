import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todos_repository.dart';

class ToggleTodoStatus implements UseCase<ToDo, Params> {
  final TodosRepository repository;

  ToggleTodoStatus(this.repository);

  @override
  Future<Either<Failure, ToDo>> call(Params params) {
    final ToDo td = params.todo.copyWith(isDone: !params.todo.isDone);
    return repository.addTodo(td);
  }
}
