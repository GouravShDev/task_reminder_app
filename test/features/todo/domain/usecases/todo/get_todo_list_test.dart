import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/get_todo_list.dart';

import 'get_todo_list_test.mocks.dart';

@GenerateMocks([TodosRepository])
void main() {
  late GetTodosList usecase;
  late MockTodosRepository mockTodosRepository;

  setUp(() {
    mockTodosRepository = MockTodosRepository();
    usecase = GetTodosList(mockTodosRepository);
  });
s
  final List<ToDo> todos = [
    ToDo(
      id: 1,
      name: 'name',
      due: DateTime.now(),
      isDone: false,
      hasAlert: true,
      repeatMode: 0,
      taskListId: 0,
    )
  ];
  test('should get todo from the repository', () async {
    // arrange
    when(mockTodosRepository.getTodosList())
        .thenAnswer((_) async => Right(todos));

    // act
    final result = await usecase(NoParams());
    // if (result.isRight()) {
    //   final List<ToDo> td = result.getOrElse(() => []);
    //   prints(td);
    // }
    result.fold((l) => Left(l), (r) {
      expect(r, todos);
      return Right(r);
    });

    // assert
    // print(result == right<Failure, List<ToDo>>(todos));
    // expect(result, isA<Right>());
    //  listEquals(result, todos);
    verify(mockTodosRepository.getTodosList());
    verifyNoMoreInteractions(mockTodosRepository);
  });
}
