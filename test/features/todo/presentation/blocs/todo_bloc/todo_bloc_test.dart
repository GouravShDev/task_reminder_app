import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/error/failures.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/add_todo.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/get_todo_list.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/toggle_todo_status.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/watch_incomp_todo_list.dart';
import 'package:todo_list/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';

import 'package:todo_list/injection_container.dart' as injector;
import '../../../../../fixtures/fixture_reader.dart';

import 'todo_bloc_test.mocks.dart';

@GenerateMocks([
  GetTodosList,
  AddTodoToDb,
  ToggleTodoStatus,
  WatchIncompTodoList,
])
void main() {
  injector.init();

  late TodoBloc bloc;
  late MockGetTodosList mockGetTodosList;
  late MockAddTodoToDb mockAddTodoToDb;
  late MockToggleTodoStatus mockToggleTodoStatus;
  late MockWatchIncompTodoList mockWatchIncompTodoList;

  setUp(() async {
    mockGetTodosList = MockGetTodosList();
    mockAddTodoToDb = MockAddTodoToDb();
    mockToggleTodoStatus = MockToggleTodoStatus();
    mockWatchIncompTodoList = MockWatchIncompTodoList();
    bloc = TodoBloc(
        getTodosList: mockGetTodosList,
        addTodoToDb: mockAddTodoToDb,
        toggleTodoStatus: mockToggleTodoStatus,
        watchIncompTodoList: mockWatchIncompTodoList);
    await injector.locator.allReady();
  });

  test('intitial State should be todoInitial', () {
    expect(bloc.state, TodoInitial());
  });

  // void getTodosUsecaseTest(TodoEvent event, Stream<List<Todo>> tTodosList) {
  //   test('should get data from getTodosList usecase', () async {
  //     //arrange
  //     when(mockWatchIncompTodoList(any)).thenAnswer((_) async => Right(tTodosList));

  //     //act
  //     bloc.add(event);
  //     await untilCalled(mockGetTodosList(any));

  //     //assert
  //     verify(mockGetTodosList(NoParams()));
  //   });
  // }

  group('GetTodos', () {
    final TodoWithTasksList td = TodoWithTasksList(
        todo: Todo.fromJson(json.decode(Fixture('todos.json'))),
        tasksList: TasksList(id: 1, name: "Default"));
    final Todo td2 = td.todo.copyWith(isDone: true, id: 99);
    final List<Todo> tTodosList = [
      td2.copyWith(id: 100),
      td2,
    ];
    Stream<List<TodoWithTasksList>> tStream = Stream.fromIterable([
      [td]
    ]);
    // getTodosUsecaseTest(WatchTodos(), tTodosList);

    test(
        'should emit [Loading, Loaded] when data is gotten successfully and return only unfinished Todo',
        () async {
      //arrange
      when(mockGetTodosList(any)).thenAnswer((_) async => Right(tTodosList));
      when(mockWatchIncompTodoList(any))
          .thenAnswer((_) async => Right(tStream));

      //assert later
      final expected = [
        TodoListLoading(),
        TodoLoaded(todoWithtasklist: [td]),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(WatchTodos());
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      // when(mockGetTodosList(any))
      //     .thenAnswer((_) async => left(DatabaseFailure()));
      when(mockWatchIncompTodoList(any))
          .thenAnswer((_) async => Left(DatabaseFailure()));

      //assert later
      final expected = [
        TodoListLoading(),
        Error(message: kErrorMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(WatchTodos());
    });
  });
  group('AddTodo', () {
    final TasksCompanion tTodo =
        Todo.fromJson(json.decode(Fixture('todos.json')))
            .copyWith(due: DateTime.now().add(Duration(hours: 1)))
            .toCompanion(true);

    final TodoWithTasksList td = TodoWithTasksList(
        todo: Todo.fromJson(json.decode(Fixture('todos.json')))
            .copyWith(due: tTodo.due.value),
        tasksList: TasksList(id: 1, name: "Default"));
    Stream<List<TodoWithTasksList>> tTodosListStream = Stream.fromIterable([
      [td]
    ]);
    test(
        'should emit [Loading, Loaded(withNewTodo)] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetTodosList(any)).thenAnswer((_) async => Right([]));
      when(mockAddTodoToDb(any)).thenAnswer((_) async => Right(tTodo.id.value));
      when(mockWatchIncompTodoList(any))
          .thenAnswer((_) async => Right(tTodosListStream));

      //assert later
      final expected = [
        TodoListLoading(),
        // TodoLoaded(todoWithtasklist: []),
        TodoLoaded(todoWithtasklist: [td]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(WatchTodos());
      bloc.add(AddTodo(tTodo));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      //arrange
      when(mockAddTodoToDb(any))
          .thenAnswer((_) async => left(DatabaseFailure()));

      //assert later
      final expected = [
        TodoListLoading(),
        Error(message: kErrorMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(AddTodo(tTodo));
    });
  });
}
