part of 'task_list_bloc.dart';

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();

  @override
  List<Object> get props => [];
}

class GetTaskLists extends TaskListEvent {}

class AddTask extends TaskListEvent {}
