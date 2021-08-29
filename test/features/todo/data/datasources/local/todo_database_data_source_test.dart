import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/data/datasources/local/DAOs/todo_dao.dart';
import 'package:todo_list/features/todo/data/datasources/local/todo_database_data_source.dart';
import 'package:todo_list/features/todo/data/models/todo_model.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  late AppDatabase appDatabase;
  late TodoDatabaseSourceImpl todoDatabaseDataSource;
  late TodoDao todoDao;
  setUp(() async {
    appDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    todoDatabaseDataSource = await TodoDatabaseSourceImpl(appDatabase);
    todoDao = appDatabase.todoDao;
  });

  tearDown(() async {
    await appDatabase.close();
  });

  final ToDo todo =
      ToDoModel.fromDatabaseJson(json.decode(Fixture('todos.json')));
  test('should call database getAllTodos method when getTodolist is called',
      () async {
    // arrange
    await todoDatabaseDataSource.storeToDo(todo);
    // act
    final result = await todoDatabaseDataSource.getTodosList();
    // assert
    expect(result, [
      ToDo(
          id: todo.id,
          due: todo.due,
          name: todo.name,
          hasAlert: todo.hasAlert,
          isDone: todo.isDone)
    ]);
  });

  test('should call database store method when storeTodo is called', () async {
    // act
    await todoDatabaseDataSource.storeToDo(todo);

    final result = await todoDao.getTodoById(todo.id!);

    expect(result, isA<ToDo>());
  });
  test(
      'should update todo when store method when storeTodo is called with todo with extisting id',
      () async {
    final ToDo updatedTodo = todo.copyWith(name: 'UpdatedTodo');
    // act
    await todoDatabaseDataSource.storeToDo(todo);
    await todoDatabaseDataSource.storeToDo(updatedTodo);

    final result = await todoDao.getTodoById(todo.id!);

    expect(result, updatedTodo);
  });
}
