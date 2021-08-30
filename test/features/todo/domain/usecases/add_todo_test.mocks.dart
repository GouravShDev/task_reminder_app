// Mocks generated by Mockito 5.0.14 from annotations
// in todo_list/test/features/todo/domain/usecases/add_todo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_list/core/error/failures.dart' as _i5;
import 'package:todo_list/features/todo/domain/entities/todo.dart' as _i6;
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [TodosRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodosRepository extends _i1.Mock implements _i3.TodosRepository {
  MockTodosRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ToDo>>> getTodosList() =>
      (super.noSuchMethod(Invocation.method(#getTodosList, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.ToDo>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.ToDo>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.ToDo>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ToDo>> addTodo(_i6.ToDo? todo) =>
      (super.noSuchMethod(Invocation.method(#addTodo, [todo]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.ToDo>>.value(
                  _FakeEither_0<_i5.Failure, _i6.ToDo>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.ToDo>>);
  @override
  String toString() => super.toString();
}
