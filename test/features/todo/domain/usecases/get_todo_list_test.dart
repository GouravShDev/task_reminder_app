import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_list.dart';

import 'get_todo_list_test.mocks.dart';

@GenerateMocks([TodosRepository])
void main() {
  late GetTodosList usecase;
  late MockTodosRepository mockTodosRepository;

  setUp(() {
    mockTodosRepository = MockTodosRepository();
    usecase = GetTodosList(mockTodosRepository);
  });

  final List<ToDo> todos = [
    ToDo(id: 1, name: 'name', due: DateTime.now(), isDone: true, hasAlert: true)
  ];
  test('should get todo from the repository', () async {
    // arrange
    when(mockTodosRepository.getTodosList())
        .thenAnswer((_) async => Right(todos));

    // act
    final result = await usecase(NoParams());

    // assert

    expect(result, Right(todos));
    verify(mockTodosRepository.getTodosList());
    verifyNoMoreInteractions(mockTodosRepository);
  });
}
