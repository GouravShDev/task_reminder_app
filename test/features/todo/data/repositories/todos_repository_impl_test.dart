import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/error/exceptions.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/data/datasources/local/todo_database_data_source.dart';
import 'package:todo_list/features/todo/data/repositories/todos_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

// @GenerateMocks([TodoDatabaseDataSource])
void main() {
  late TodoRepositoryImpl repository;
  late MockTodoDatabaseDataSource mockTodoDatabaseDataSource;

  setUp(() {
    mockTodoDatabaseDataSource = MockTodoDatabaseDataSource();
    repository =
        TodoRepositoryImpl(databaseDataSource: mockTodoDatabaseDataSource);
  });

  group(('getTodoList'), () {
    final List<Todo> tTodos = [
      Todo.fromJson(json.decode(Fixture('todos.json'))),
    ];

    test('should return todoList when call to database sources is successful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.getAllTodos())
          .thenAnswer((_) async => tTodos);
      // act
      final result = await repository.getTodosList();
      // assert
      verify(mockTodoDatabaseDataSource.getTodosList());
      expect(result, Right(tTodos));
    });

    test(
        'should return database failure when the call to datasource is unsuccessful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.getTodosList())
          .thenThrow(DatabaseException());
      // act
      final result = await repository.getTodosList();
      // assert
      verify(mockTodoDatabaseDataSource.getTodosList());
      expect(result, left(DatabaseFailure()));
    });
  });

  group('addTodo', () {
    final todo =
        ToDo(name: 'name', due: DateTime.now(), isDone: true, hasAlert: true);
    test('should return todo when insert to datasource is successful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.storeToDo(any))
          .thenAnswer((_) async => todo);

      // act
      final result = await repository.addTodo(todo);

      // assert
      verify(mockTodoDatabaseDataSource.storeToDo(todo));
      expect(result, Right(todo));
    });

    test(
        'should return database failure when the call to datasource is unsuccessful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.storeToDo(any))
          .thenThrow(DatabaseException());
      // act
      final result = await repository.addTodo(todo);
      // assert
      verify(mockTodoDatabaseDataSource.storeToDo(todo));
      expect(result, left(DatabaseFailure()));
    });
  });
}
