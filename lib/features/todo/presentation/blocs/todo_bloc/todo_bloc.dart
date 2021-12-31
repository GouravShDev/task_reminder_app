import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/datasources/local/database/app_database.dart';
import '../../../domain/usecases/todo/watch_incomp_todo_list.dart';
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
  }) : super(TodoInitial());

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is WatchTodos) {
      yield TodoListLoading();
      final resulting = await watchIncompTodoList(NoParams());
      resulting.fold((failure) => Error(message: _mapFailureToMessage(failure)),
          (stream) {
        streamSubscription = stream.listen((todos) {
          add(TodoListUpdated(todosList: todos));
        });
      });
    } else if (event is AddTodo) {
      yield TodoListLoading();
      final addTodoEither = await addTodoToDb(TodoParams(event.todo));
      yield* addTodoEither.fold((failure) async* {
        yield Error(message: _mapFailureToMessage(failure));
      }, (_) async* {});
    } else if (event is TodoListUpdated) {
      yield TodoLoaded(todoWithtasklist: event.todosList);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return kErrorMessage;
      default:
        return "Unknow Failure Occured";
    }
  }
}
