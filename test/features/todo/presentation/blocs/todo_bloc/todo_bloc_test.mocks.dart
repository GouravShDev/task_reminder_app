// Mocks generated by Mockito 5.0.14 from annotations
// in todo_list/test/features/todo/presentation/blocs/todo_bloc/todo_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_list/core/error/failures.dart' as _i7;
import 'package:todo_list/core/services/notification_service.dart' as _i4;
import 'package:todo_list/core/usecases/usecase.dart' as _i8;
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart'
    as _i2;
import 'package:todo_list/features/todo/domain/usecases/todo/add_todo.dart'
    as _i9;
import 'package:todo_list/features/todo/domain/usecases/todo/get_todo_list.dart'
    as _i5;
import 'package:todo_list/features/todo/domain/usecases/todo/toggle_todo_status.dart'
    as _i10;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTodosRepository_0 extends _i1.Fake implements _i2.TodosRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeNotificationService_2 extends _i1.Fake
    implements _i4.NotificationService {}

/// A class which mocks [GetTodosList].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTodosList extends _i1.Mock implements _i5.GetTodosList {
  MockGetTodosList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodosRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodosRepository_0()) as _i2.TodosRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<dynamic>>> call(
          _i8.NoParams? noParams) =>
      (super.noSuchMethod(Invocation.method(#call, [noParams]),
              returnValue: Future<_i3.Either<_i7.Failure, List<dynamic>>>.value(
                  _FakeEither_1<_i7.Failure, List<dynamic>>()))
          as _i6.Future<_i3.Either<_i7.Failure, List<dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [AddTodoToDb].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTodoToDb extends _i1.Mock implements _i9.AddTodoToDb {
  MockAddTodoToDb() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodosRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodosRepository_0()) as _i2.TodosRepository);
  @override
  _i4.NotificationService get notificationService => (super.noSuchMethod(
      Invocation.getter(#notificationService),
      returnValue: _FakeNotificationService_2()) as _i4.NotificationService);
  @override
  _i6.Future<_i3.Either<_i7.Failure, int>> call(_i9.TodoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i3.Either<_i7.Failure, int>>.value(
                  _FakeEither_1<_i7.Failure, int>()))
          as _i6.Future<_i3.Either<_i7.Failure, int>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [ToggleTodoStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockToggleTodoStatus extends _i1.Mock implements _i10.ToggleTodoStatus {
  MockToggleTodoStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodosRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodosRepository_0()) as _i2.TodosRepository);
  @override
  _i4.NotificationService get notificationService => (super.noSuchMethod(
      Invocation.getter(#notificationService),
      returnValue: _FakeNotificationService_2()) as _i4.NotificationService);
  @override
  _i6.Future<_i3.Either<_i7.Failure, int>> call(_i9.TodoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i3.Either<_i7.Failure, int>>.value(
                  _FakeEither_1<_i7.Failure, int>()))
          as _i6.Future<_i3.Either<_i7.Failure, int>>);
  @override
  String toString() => super.toString();
}
