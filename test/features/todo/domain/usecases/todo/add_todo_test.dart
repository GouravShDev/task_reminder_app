import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/services/notification_service.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/add_todo.dart';

import 'toggle_todo_status_test.mocks.dart';

@GenerateMocks([TodosRepository, NotificationService])
void main() {
  late AddTodoToDb usecase;
  late MockTodosRepository mockTodosRepository;
  late MockNotificationService mockNotificationService;
  setUp(() {
    mockTodosRepository = MockTodosRepository();
    mockNotificationService = MockNotificationService();
    usecase = AddTodoToDb(mockTodosRepository, mockNotificationService);
  });

  final ToDo todo =
      ToDo(name: 'name', due: DateTime.now(), isDone: true, hasAlert: true);
  test(
      'should get todo after adding to database through the repository and schedule notification if alert is on',
      () async {
    final ToDo expectedTodo = todo.copyWith(id: 1);
    // arrange
    when(mockTodosRepository.addTodo(any))
        .thenAnswer((_) async => Right(expectedTodo));

    // act
    final result = await usecase(Params(todo));

    // assert

    expect(result, Right(expectedTodo));
    untilCalled(mockNotificationService.scheduledNotification(
        id: anyNamed('id'),
        message: anyNamed('message'),
        scheduledDate: anyNamed('scheduledDate'),
        title: anyNamed('title')));
    verify(mockTodosRepository.addTodo(any));
    verifyNoMoreInteractions(mockTodosRepository);
  });
}
