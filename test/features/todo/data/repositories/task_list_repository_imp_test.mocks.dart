// Mocks generated by Mockito 5.0.15 from annotations
// in todo_list/test/features/todo/data/repositories/task_list_repository_imp_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart'
    as _i4;
import 'package:todo_list/features/todo/data/datasources/local/todo_database_data_source.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [TodoDatabaseDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoDatabaseDataSource extends _i1.Mock
    implements _i2.TodoDatabaseDataSource {
  MockTodoDatabaseDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Todo>> getAllTodos() =>
      (super.noSuchMethod(Invocation.method(#getAllTodos, []),
              returnValue: Future<List<_i4.Todo>>.value(<_i4.Todo>[]))
          as _i3.Future<List<_i4.Todo>>);
  @override
  _i3.Stream<List<_i4.TodoWithTasksList>> watchIncompTodosAsStream() =>
      (super.noSuchMethod(Invocation.method(#watchIncompTodosAsStream, []),
              returnValue: Stream<List<_i4.TodoWithTasksList>>.empty())
          as _i3.Stream<List<_i4.TodoWithTasksList>>);
  @override
  _i3.Future<int> storeTodo(_i4.TasksCompanion? todo) =>
      (super.noSuchMethod(Invocation.method(#storeTodo, [todo]),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  _i3.Future<List<_i4.TasksList>> getAllTaskLists() =>
      (super.noSuchMethod(Invocation.method(#getAllTaskLists, []),
              returnValue: Future<List<_i4.TasksList>>.value(<_i4.TasksList>[]))
          as _i3.Future<List<_i4.TasksList>>);
  @override
  _i3.Future<int> storeTasksList(_i4.TasksListTableCompanion? taskList) =>
      (super.noSuchMethod(Invocation.method(#storeTasksList, [taskList]),
          returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  void deleteTasksList(_i4.TasksList? taskList) =>
      super.noSuchMethod(Invocation.method(#deleteTasksList, [taskList]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<List<_i4.TasksList>> watchTaskListsAsStream() =>
      (super.noSuchMethod(Invocation.method(#watchTaskListsAsStream, []),
              returnValue: Stream<List<_i4.TasksList>>.empty())
          as _i3.Stream<List<_i4.TasksList>>);
  @override
  String toString() => super.toString();
}
