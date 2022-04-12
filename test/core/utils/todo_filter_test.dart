import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/core/utils/constants.dart';
import 'package:todo_list/core/utils/todo_filter.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  late TodoFilter todoFilter;

  setUp(() {
    todoFilter = TodoFilter();
  });

  group('filterTodos', () {
    final tTodaysTodo = Todo(
      id: 3,
      name: 'name',
      due: DateTime.now().add(Duration(seconds: 100)),
      isDone: true,
      hasAlert: true,
      repeatMode: 0,
      tasklistId: 0,
    );
    final tFutureTodo = Todo(
        id: 1,
        name: 'name',
        due: DateTime.now().add(Duration(days: 1)),
        isDone: true,
        repeatMode: 0,
        tasklistId: 0,
        hasAlert: true);
    final tOverDueTodo = Todo.fromJson(json.decode(Fixture('todos.json')));
    final tTodosList = [
      TodoWithTasksList(
          todo: tOverDueTodo, tasksList: TasksList(id: 1, name: 'test')),
      TodoWithTasksList(
          todo: tTodaysTodo, tasksList: TasksList(id: 1, name: 'test')),
      TodoWithTasksList(
          todo: tFutureTodo, tasksList: TasksList(id: 1, name: 'test')),
    ];

    test(
        'should return list of todos containing todays todo when call with kTodayTodo',
        () {
      // act
      final result = todoFilter.filterTodos(tTodosList, kTodayTodo);

      // assert
      expect(result, [
        TodoWithTasksList(
            todo: tTodaysTodo, tasksList: TasksList(id: 1, name: 'test'))
      ]);
    });
    test(
        'should return list of todos containing upcoming todo when call with kUpcomingTodo',
        () {
      // act
      final result = todoFilter.filterTodos(tTodosList, kUpcomingTodo);

      // assert
      expect(result, [
        TodoWithTasksList(
            todo: tFutureTodo, tasksList: TasksList(id: 1, name: 'test'))
      ]);
    });
    test(
        'should return list of todos containing overdue todo when call with kOverdueTodo',
        () {
      // act
      final result = todoFilter.filterTodos(tTodosList, kOverdueTodo);

      // assert
      expect(result, [
        TodoWithTasksList(
            todo: tOverDueTodo, tasksList: TasksList(id: 1, name: 'test'))
      ]);
    });
  });
}
