import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/todo/data/models/todo_model.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tToDoModel = ToDoModel(
      id: 1,
      due: DateTime.parse("2021-08-21T13:00:00.000"),
      hasAlert: true,
      isDone: false,
      name: 'test');

  test('should be a subclass of ToDo entity', () {
    // assert
    expect(tToDoModel, isA<ToDo>());
  });

  group('from Json', () {
    test('should return a valid model when fromDatabaseJson called', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(Fixture('todos.json'));
      // act
      final result = ToDoModel.fromDatabaseJson(jsonMap);
      // assert
      expect(result, tToDoModel);
    });
  });

  group('toJson', () {
    test('should return a valid json when toJson called', () {
      // act
      final result = tToDoModel.toJson();
      // assert
      final expectedMap = {
        "id": 1,
        "name": "test",
        "due": "2021-08-21T13:00:00.000",
        "isDone": 0,
        "hasAlert": 1
      };
      expect(result, expectedMap);
    });
  });
}
