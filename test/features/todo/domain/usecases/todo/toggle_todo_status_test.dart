import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/services/notification_service.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/add_todo.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/toggle_todo_status.dart';

import 'toggle_todo_status_test.mocks.dart';

@GenerateMocks([TodosRepository, NotificationService])
void main() {
  late ToggleTodoStatus usecase;
  late MockTodosRepository mockTodosRepository;
  late MockNotificationService mockNotificationService;
  setUp(() {
    mockTodosRepository = MockTodosRepository();
    mockNotificationService = MockNotificationService();
    usecase = ToggleTodoStatus(mockTodosRepository, mockNotificationService);
  });

  final ToDo todo = ToDo(
      id: 1, name: 'name', due: DateTime.now(), isDone: true, hasAlert: true);
  test(
      'should change todo isDone property after updating to database and cancel notfication schedule through the repository',
      () async {
    final ToDo expectedTodo = todo.copyWith(isDone: false);
    // arrange
    when(mockTodosRepository.addTodo(any))
        .thenAnswer((_) async => Right(expectedTodo));

    // act
    final result = await usecase(Params(todo));

    // assert

    expect(result, Right(expectedTodo));
    verify(mockTodosRepository.addTodo(any));
    untilCalled(mockNotificationService.cancelNotification(todo.id));
    verifyNoMoreInteractions(mockTodosRepository);
  });
}
