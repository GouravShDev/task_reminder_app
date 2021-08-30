import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/core/services/notification_service.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/todo/data/models/todo_model.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_list.dart';
import 'package:todo_list/features/todo/domain/usecases/toggle_todo_status.dart';
import 'package:todo_list/features/todo/presentation/bloc/todo_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'package:todo_list/injection_container.dart' as injector;
import 'todo_bloc_test.mocks.dart';

@GenerateMocks(
    [GetTodosList, AddTodoToDb, ToggleTodoStatus, NotificationService])
void main() {
  injector.init();

  late TodoBloc bloc;
  late MockGetTodosList mockGetTodosList;
  late MockAddTodoToDb mockAddTodoToDb;
  late MockToggleTodoStatus mockToggleTodoStatus;
  late MockNotificationService mockNotificationService;

  setUp(() async {
    mockGetTodosList = MockGetTodosList();
    mockAddTodoToDb = MockAddTodoToDb();
    mockToggleTodoStatus = MockToggleTodoStatus();
    mockNotificationService = MockNotificationService();
    bloc = TodoBloc(
        getTodosList: mockGetTodosList,
        addTodoToDb: mockAddTodoToDb,
        toggleTodoStatus: mockToggleTodoStatus,
        notificationService: mockNotificationService);
    await injector.locator.allReady();
  });

  test('intitial State should be todoInitial', () {
    expect(bloc.state, TodoInitial());
  });

  void getTodosUsecaseTest(TodoEvent event, List<ToDo> tTodosList) {
    test('should get data from getTodosList usecase', () async {
      //arrange
      when(mockGetTodosList(any)).thenAnswer((_) async => Right(tTodosList));

      //act
      bloc.add(event);
      await untilCalled(mockGetTodosList(any));

      //assert
      verify(mockGetTodosList(NoParams()));
    });
  }

  group('GetTodos', () {
    final ToDo td =
        ToDoModel.fromDatabaseJson(json.decode(Fixture('todos.json')));
    final ToDo td2 = td.copyWith(isDone: true, id: 99);
    final List<ToDo> tTodosList = [
      td,
      td2,
    ];
    getTodosUsecaseTest(GetTodos(), tTodosList);

    test(
        'should emit [Loading, Loaded] when data is gotten successfully and return only unfinished Todo',
        () async {
      //arrange
      when(mockGetTodosList(any)).thenAnswer((_) async => Right(tTodosList));

      //assert later
      final expected = [
        Loading(),
        Loaded(todos: [td]),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTodos());
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      when(mockGetTodosList(any))
          .thenAnswer((_) async => left(DatabaseFailure()));

      //assert later
      final expected = [
        Loading(),
        Error(message: kErrorMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTodos());
    });
  });
  group('AddTodo', () {
    final ToDo tTodo =
        ToDoModel.fromDatabaseJson(json.decode(Fixture('todos.json')))
            .copyWith(due: DateTime.now().add(Duration(hours: 1)));

    test(
        'should emit [Loading, Loaded,Loaded(withNewTodo)] when data is gotten successfully and schedule notification if alert is on',
        () async {
      //arrange
      when(mockGetTodosList(any)).thenAnswer((_) async => Right([]));
      when(mockAddTodoToDb(any)).thenAnswer((_) async => Right(tTodo));

      //assert later
      final expected = [
        Loading(),
        Loaded(todos: []),
        Loaded(todos: [tTodo]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTodos());
      bloc.add(AddTodo(tTodo));

      // asset
      await untilCalled(mockNotificationService.scheduledNotification(
          id: tTodo.id,
          message: anyNamed('message'),
          scheduledDate: tTodo.due,
          title: tTodo.name));

      verify(mockNotificationService.scheduledNotification(
          id: tTodo.id,
          message: anyNamed('message'),
          scheduledDate: tTodo.due,
          title: tTodo.name));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      when(mockAddTodoToDb(any))
          .thenAnswer((_) async => left(DatabaseFailure()));

      //assert later
      final expected = [
        Error(message: kErrorMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(AddTodo(tTodo));
    });
  });
  group('ChangeTodoStatus', () {
    final ToDo tTodo =
        ToDoModel.fromDatabaseJson(json.decode(Fixture('todos.json')));
    final ToDo tTodoToggled = tTodo.copyWith(isDone: !tTodo.isDone);

    test(
        'should emit [Loading, Loaded,Loaded(withUpdateTodo)] when data is gotten successfully and remove schedule notification',
        () async {
      //arrange
      when(mockGetTodosList(any)).thenAnswer((_) async => Right([tTodo]));

      when(mockToggleTodoStatus(any))
          .thenAnswer((_) async => Right(tTodoToggled));

      //assert later
      final expected = [
        Loading(),
        Loaded(todos: [tTodo]),
        Loaded(todos: []),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTodos());
      bloc.add(ChangeTodoStatus(tTodo));

      // asset
      await untilCalled(mockNotificationService.cancelNotification(tTodo.id));
      verify(mockNotificationService.cancelNotification(tTodo.id));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      when(mockToggleTodoStatus(any))
          .thenAnswer((_) async => left(DatabaseFailure()));

      //assert later
      final expected = [
        Error(message: kErrorMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(ChangeTodoStatus(tTodo));
    });
  });
}
