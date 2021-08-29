import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todos_repository.dart';

class AddTodoToDb implements UseCase<ToDo, Params> {
  final TodosRepository repository;

  AddTodoToDb(this.repository);

  @override
  Future<Either<Failure, ToDo>> call(Params params) {
    return repository.addTodo(params.todo);
  }
}
