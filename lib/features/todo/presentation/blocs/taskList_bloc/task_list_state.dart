part of 'task_list_bloc.dart';

abstract class TaskListState extends Equatable {
  const TaskListState();

  @override
  List<Object> get props => [];
}

class TaskListInitial extends TaskListState {}

class TaskListsLoaded extends TaskListState {
  final List<TaskList> taskList;

  TaskListsLoaded(this.taskList);
}

class TaskListError extends TaskListState {
  final String message;

  TaskListError({required this.message});
}
