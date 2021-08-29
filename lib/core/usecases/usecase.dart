import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../features/todo/domain/entities/todo.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class Params {
  final ToDo todo;

  Params(this.todo);
}
