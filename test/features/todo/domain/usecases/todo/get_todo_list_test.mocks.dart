// Mocks generated by Mockito 5.1.0 from annotations
// in todo_list/test/features/todo/domain/usecases/todo/get_todo_list_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_list/core/error/failures.dart' as _i5;
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart'
    as _i6;
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [TodosRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodosRepository extends _i1.Mock implements _i3.TodosRepository {
  MockTodosRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Todo>>> getTodosList() =>
      (super.noSuchMethod(Invocation.method(#getTodosList, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Todo>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Todo>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Todo>>>);
  @override
  _i2.Either<_i5.Failure, _i4.Stream<List<_i6.TodoWithTasksList>>>
      watchIncompTodosList() => (super.noSuchMethod(
              Invocation.method(#watchIncompTodosList, []),
              returnValue: _FakeEither_0<_i5.Failure,
                  _i4.Stream<List<_i6.TodoWithTasksList>>>())
          as _i2.Either<_i5.Failure, _i4.Stream<List<_i6.TodoWithTasksList>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> addTodo(_i6.TasksCompanion? todo) =>
      (super.noSuchMethod(Invocation.method(#addTodo, [todo]),
              returnValue: Future<_i2.Either<_i5.Failure, int>>.value(
                  _FakeEither_0<_i5.Failure, int>()))
          as _i4.Future<_i2.Either<_i5.Failure, int>>);
}
