import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';
import 'package:todo_list/core/error/exceptions.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/data/datasources/local/todo_database_data_source.dart';
import 'package:todo_list/features/todo/data/repositories/task_list_repository_impl.dart';

import 'task_list_repository_imp_test.mocks.dart';

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
    final List<TasksList> tTaskList = [
      TasksList(name: 'name', id: 1),
    ];

    test(
        'should return list of taskList when call to database sources is successful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.getAllTaskLists())
          .thenAnswer((_) async => tTaskList);
      // act
      final result = await repository.getAllTaskLists();
      // assert
      verify(mockTodoDatabaseDataSource.getAllTaskLists());
      expect(result, Right(tTaskList));
    });

    test(
        'should return database failure when the call to datasource is unsuccessful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.getAllTaskLists())
          .thenThrow(DatabaseException());
      // act
      final result = await repository.getAllTaskLists();
      // assert
      verify(mockTodoDatabaseDataSource.getAllTaskLists());
      expect(result, left(DatabaseFailure()));
    });
  });

  group('addTodo', () {
    final TasksList taskList = TasksList(name: 'name', id: 1);
    test('should return taskList id when insert to datasource is successful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.storeTasksList(any))
          .thenAnswer((_) async => taskList.id);

      // act
      final result = await repository
          .addTaskList(TasksListTableCompanion(name: Value(taskList.name)));

      // assert
      verify(mockTodoDatabaseDataSource
          .storeTasksList(TasksListTableCompanion(name: Value(taskList.name))));
      expect(result, Right((taskList.id)));
    });

    test(
        'should return database failure when the call to datasource is unsuccessful',
        () async {
      // arrange
      when(mockTodoDatabaseDataSource.storeTasksList(any))
          .thenThrow(DatabaseException());
      // act
      final result = await repository
          .addTaskList(TasksListTableCompanion(name: Value(taskList.name)));
      // assert
      verify(mockTodoDatabaseDataSource
          .storeTasksList(TasksListTableCompanion(name: Value(taskList.name))));
      expect(result, left(DatabaseFailure()));
    });
  });
}
