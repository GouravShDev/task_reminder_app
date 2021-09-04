part of 'task_list_bloc.dart';

abstract class TaskListState extends Equatable {
  const TaskListState();

  @override
  List<Object> get props => [];
}

class TaskListInitial extends TaskListState {}

class TaskListsLoaded extends TaskListState {
  final List<TasksList> taskList;
  final int? newTaskListid;
  TaskListsLoaded({
    required this.taskList,
    this.newTaskListid,
  });
  @override
  List<Object> get props => [taskList];
}

class TaskListAdded extends TaskListState {
  final int newId;

  TaskListAdded(this.newId);
}

class TaskListError extends TaskListState {
  final String message;

  TaskListError({required this.message});
}
