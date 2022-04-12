import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';
import 'package:todo_list/core/services/notification_service.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/domain/repositories/todos_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/add_todo.dart';

import 'add_todo_test.mocks.dart';


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

  final Todo todo = Todo(
      id: 1,
      name: 'name',
      due: DateTime.now(),
      isDone: true,
      hasAlert: true,
      tasklistId: 0,
      repeatMode: 0);
  test(
      'should get todo after adding to database through the repository and schedule notification if alert is on',
      () async {
    // arrange
    when(mockTodosRepository.addTodo(any))
        .thenAnswer((_) async => Right(todo.id));

    // act
    final result = await usecase(TodoParams(TasksCompanion(
      due: Value(todo.due),
      hasAlert: Value(todo.hasAlert),
      isDone: Value(todo.hasAlert),
      name: Value(todo.name),
      repeatMode: Value(todo.repeatMode),
      tasklistId: Value(todo.tasklistId),
    )));

    // assert

    expect(result, Right(todo.id));
    untilCalled(mockNotificationService.scheduledNotification(
        id: anyNamed('id'),
        message: anyNamed('message'),
        scheduledDate: anyNamed('scheduledDate'),
        title: anyNamed('title')));
    verify(mockTodosRepository.addTodo(any));
    verifyNoMoreInteractions(mockTodosRepository);
  });
}
