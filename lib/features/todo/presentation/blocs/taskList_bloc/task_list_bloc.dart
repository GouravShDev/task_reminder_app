import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/taskList/get_task_list.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

const String kErrorMessage = "There was some internal Error";

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final GetAllTaskList getAllTaskList;
  TaskListBloc({required this.getAllTaskList}) : super(TaskListInitial());

  @override
  Stream<TaskListState> mapEventToState(
    TaskListEvent event,
  ) async* {
    if (event is TaskListsLoaded) {
      final taskListEither = await getAllTaskList(NoParams());
      yield taskListEither.fold(
          (failure) => TaskListError(message: _mapFailureToMessage(failure)),
          (taskLists) => TaskListsLoaded(taskLists));
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
