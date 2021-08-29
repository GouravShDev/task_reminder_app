import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/add_todo.dart';

import 'toggle_todo_status_test.mocks.dart';

// @GenerateMocks([TodosRepository])
void main() {
  late AddTodoToDb usecase;
  late MockTodosRepository mockTodosRepository;
  setUp(() {
    mockTodosRepository = MockTodosRepository();
    usecase = AddTodoToDb(mockTodosRepository);
  });

  final ToDo todo =
      ToDo(name: 'name', due: DateTime.now(), isDone: true, hasAlert: true);
  test('should get todo after adding to database through the repository',
      () async {
    final ToDo expectedTodo = todo.copyWith(id: 1);
    // arrange
    when(mockTodosRepository.addTodo(any))
        .thenAnswer((_) async => Right(expectedTodo));

    // act
    final result = await usecase(Params(todo));

    // assert

    expect(result, Right(expectedTodo));
    verify(mockTodosRepository.addTodo(any));
    verifyNoMoreInteractions(mockTodosRepository);
  });
}
