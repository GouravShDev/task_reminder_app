import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/error/exceptions.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/features/todo/data/datasources/local/todo_database_data_source.dart';
import 'package:todo_list/features/todo/data/repositories/task_list_repository_impl.dart';
import 'package:todo_list/features/todo/domain/entities/task_list.dart';

import 'todos_repository_impl_test.mocks.dart';

@GenerateMocks([TodoDatabaseDataSource])
void main() {
  late TaskListRepositoryImpl repository;
  late MockTodoDatabaseDataSource mockTodoDatabaseDataSource;

  setUp(() {
    mockTodoDatabaseDataSource = MockTodoDatabaseDataSource();
    repository =
        TaskListRepositoryImpl(databaseDataSource: mockTodoDatabaseDataSource);
  });

  group(('getTodoList'), () {
    final List<TaskList> tTaskList = [
      TaskList(name: 'name', id: 1),
    ];

    test(
        'should return list of taskList when call to database sources is successful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.getTaskLists())
          .thenAnswer((_) async => tTaskList);
      // act
      final result = await repository.getAllTaskLists();
      // assert
      verify(mockTodoDatabaseDataSource.getTaskLists());
      expect(result, Right(tTaskList));
    });

    test(
        'should return database failure when the call to datasource is unsuccessful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.getTaskLists())
          .thenThrow(DatabaseException());
      // act
      final result = await repository.getAllTaskLists();
      // assert
      verify(mockTodoDatabaseDataSource.getTaskLists());
      expect(result, left(DatabaseFailure()));
    });
  });

  group('addTodo', () {
    final TaskList taskList = TaskList(name: 'name');
    test('should return taskList when insert to datasource is successful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.storeTaskList(any))
          .thenAnswer((_) async => taskList);

      // act
      final result = await repository.addTaskList(taskList);

      // assert
      verify(mockTodoDatabaseDataSource.storeTaskList(taskList));
      expect(result, Right(taskList));
    });

    test(
        'should return database failure when the call to datasource is unsuccessful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.storeTaskList(any))
          .thenThrow(DatabaseException());
      // act
      final result = await repository.addTaskList(taskList);
      // assert
      verify(mockTodoDatabaseDataSource.storeTaskList(taskList));
      expect(result, left(DatabaseFailure()));
    });
  });
}
