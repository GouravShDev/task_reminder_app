// import '';

import 'package:dartz/dartz.dart';

import '/features/todo/domain/entities/todo.dart';
import '../../../../core/error/failures.dart';

abstract class TodosRepository {
  Future<Either<Failure, List<ToDo>>> getTodosList();

  Future<Either<Failure, ToDo>> addTodo(ToDo todo);
}
