// import '';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '/features/todo/domain/entities/todo.dart';

abstract class TodosRepository {
  Future<Either<Failure, List<ToDo>>> getTodosList();

  Future<Either<Failure, ToDo>> addTodo(ToDo todo);
}
