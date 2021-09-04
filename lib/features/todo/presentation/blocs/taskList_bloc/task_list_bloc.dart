import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import 'package:todo_list/features/todo/domain/usecases/taskList/add_task_list.dart';
import 'package:todo_list/features/todo/domain/usecases/taskList/delete_task_list.dart';
import 'package:todo_list/features/todo/domain/usecases/taskList/watch_task_list.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/taskList/get_task_list.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

const String kErrorMessage = "There was some internal Error";

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final GetAllTaskList getAllTaskList;
  final WatchTasksList watchTasksList;
  final AddTaskList addTaskList;
  final DeleteTaskList deleteTaskList;
  late StreamSubscription streamSubscription;
  TaskListBloc({
    required this.getAllTaskList,
    required this.watchTasksList,
    required this.addTaskList,
    required this.deleteTaskList,
  }) : super(TaskListInitial()) {
    _initStream();
  }
  void _initStream() async {
    final resulting = await watchTasksList(NoParams());
    resulting.fold(
        (failure) => TaskListError(message: _mapFailureToMessage(failure)),
        (stream) {
      streamSubscription = stream.listen((taskLists) {
        // print(taskLists.length);
        final currentState = state;
        if (currentState is TaskListAdded) {
          add(TaskListUpdated(taskLists: taskLists, newId: currentState.newId));
        } else {
          add(TaskListUpdated(taskLists: taskLists));
        }
      });
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<TaskListState> mapEventToState(
    TaskListEvent event,
  ) async* {
    if (event is GetTaskLists) {
      // final taskListEither = await getAllTaskList(NoParams());
      // yield* taskListEither.fold((failure) async* {
      //   yield TaskListError(message: _mapFailureToMessage(failure));
      // }, (taskLists) async* {
      //   final currentState = state;
      //   if (currentState is TaskListsLoaded) {
      //     yield TaskListsAdded(taskList: currentState.taskList);
      //   }
      // });
    } else if (event is TaskListUpdated) {
      yield TaskListsLoaded(
          taskList: event.taskLists, newTaskListid: event.newId);
    } else if (event is AddTaskListEvent) {
      final currentState = state;
      if (currentState is TaskListsLoaded) {
        final tasksList = currentState.taskList;
        final indexIfAlreadyInList = tasksList
            .indexWhere((element) => element.name == event.taskList.name.value);
        if (indexIfAlreadyInList > 0) {
          // yield TaskListError(message: 'List already exists with same name');
          return;
        }
      }
      final taskListEither =
          await addTaskList(TasksListCompParams(event.taskList));
      yield* taskListEither.fold((failure) async* {
        yield TaskListError(message: _mapFailureToMessage(failure));
      }, (newId) async* {
        // final currentState = state;
        // if (currentState is TaskListsAdded) {
        //   final List<TasksList> newTasksList = List.from(currentState.taskList);
        //   newTasksList
        //       .add(TasksList(id: newId, name: event.taskList.name.value));
        yield TaskListAdded(newId);
        // }
      });
    } else if (event is DeleteTaskListEvent) {
      final taskListEither =
          await deleteTaskList(TasksListParams(event.tasksList));
      yield* taskListEither.fold((failure) async* {
        yield TaskListError(message: _mapFailureToMessage(failure));
      }, (_) async* {});
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
