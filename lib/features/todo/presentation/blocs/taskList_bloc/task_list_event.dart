part of 'task_list_bloc.dart';

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();

  @override
  List<Object> get props => [];
}

class GetTaskLists extends TaskListEvent {}

class AddTaskListEvent extends TaskListEvent {
  final TasksListTableCompanion taskList;

  AddTaskListEvent(this.taskList);
}

class TaskListUpdated extends TaskListEvent {
  final List<TasksList> taskLists;
  final int? newId;
  TaskListUpdated({required this.taskLists, this.newId});
  @override
  List<Object> get props => [taskLists];
}

class DeleteTaskListEvent extends TaskListEvent {
  final TasksList tasksList;

  DeleteTaskListEvent(this.tasksList);
}
// class TaskListAdded extends