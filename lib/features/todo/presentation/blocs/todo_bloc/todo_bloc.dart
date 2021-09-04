import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/domain/usecases/todo/watch_incomp_todo_list.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/todo/add_todo.dart';
import '../../../domain/usecases/todo/get_todo_list.dart';
import '../../../domain/usecases/todo/toggle_todo_status.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const String kErrorMessage = "There was some internal Error";

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosList getTodosList;
  final AddTodoToDb addTodoToDb;
  final ToggleTodoStatus toggleTodoStatus;
  final WatchIncompTodoList watchIncompTodoList;
  // final NotificationService notificationService;
  late StreamSubscription streamSubscription;

  TodoBloc({
    required this.getTodosList,
    required this.addTodoToDb,
    required this.toggleTodoStatus,
    required this.watchIncompTodoList,
    // required this.notificationService,
  }) : super(TodoInitial()) {
    _initStream();
  }

  void _initStream() async {
    final resulting = await watchIncompTodoList(NoParams());
    resulting.fold((failure) => Error(message: _mapFailureToMessage(failure)),
        (stream) {
      streamSubscription = stream.listen((todos) {
        print(todos);
        // final todoList = todos
        //     .map((todo) => Todo(
        //           id: todo.todo.id,
        //           hasAlert: todo.todo.hasAlert,
        //           isDone: todo.todo.isDone,
        //           name: todo.todo.name,
        //           repeatMode: todo.todo.repeatMode,
        //           tasklistId: todo.todo.tasklistId,
        //           due: todo.todo.due,
        //         ))
        //     .toList();
        add(TodoListUpdated(todosList: todos));
      });
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is GetTodos) {
      // yield Loading();
      // final getTodoEither = await getTodosList(NoParams());
      // yield getTodoEither.fold(
      //     (failure) => Error(message: _mapFailureToMessage(failure)),
      //     (todoList) =>
      //         Loaded(todos: todoList.where((todo) => !todo.isDone).toList()));
    } else if (event is AddTodo) {
      final addTodoEither = await addTodoToDb(TodoParams(event.todo));
      yield* addTodoEither.fold((failure) async* {
        yield Error(message: _mapFailureToMessage(failure));
      }, (_) async* {
        // _scheduleNotification(todo);
        // final currentState = state;
        // if (currentState is Loaded) {
        //   final List<Todo> currentList = List.from(currentState.todos);
        //   yield Loaded(todos: _replaceTodoAndUpdatelist(currentList, todo));
        // }
      });
    } else if (event is TodoListUpdated) {
      yield TodoLoaded(todoWithtasklist: event.todosList);
    }
    // else if (event is ChangeTodoStatus) {
    //   final changeTodoEither = await toggleTodoStatus(Params(event.todo));
    //   yield* changeTodoEither.fold((failure) async* {
    //     yield Error(message: _mapFailureToMessage(failure));
    //   }, (todo) async* {
    //     final currentState = state;
    //     // _cancelNotification(todo);
    //     if (currentState is Loaded) {
    //       final List<Todo> currentList = List.from(currentState.todos);
    //       yield Loaded(
    //           todos: _replaceTodoAndUpdatelist(currentList, todo)
    //               .where((element) => !element.isDone)
    //               .toList());
    //     }
    //   });
    // }
  }

  // void _scheduleNotification(Todo td) {
  //   if (td.hasAlert && td.due.isAfter(DateTime.now())) {
  //     notificationService.scheduledNotification(
  //         id: td.id!,
  //         message: formatDate(DateTime(2019, 08, 1, td.due.hour, td.due.minute),
  //             [hh, ':', nn, " ", am]).toString(),
  //         title: td.name,
  //         scheduledDate: td.due);
  //   }
  // }

  // void _cancelNotification(Todo td) {
  //   if (td.hasAlert) {
  //     notificationService.cancelNotification(td.id!);
  //   }
  // }

  // List<Todo> _replaceTodoAndUpdatelist(List<Todo> todoList, Todo newTodo) {
  //   final index = todoList.indexWhere((todoItem) => todoItem.id == newTodo.id);
  //   if (index != -1) {
  //     todoList[index] = newTodo;
  //   } else {
  //     todoList.add(newTodo);
  //     todoList.sort((a, b) => a.due.compareTo(b.due));
  //   }
  //   return todoList;
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return kErrorMessage;
      default:
        return "Unknow Failure Occured";
    }
  }
}
