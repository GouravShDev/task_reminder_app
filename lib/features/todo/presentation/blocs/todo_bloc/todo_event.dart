part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class WatchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final TasksCompanion todo;

  AddTodo(this.todo);
}

class ChangeTodoStatus extends TodoEvent {
  final Todo todo;

  ChangeTodoStatus(this.todo);
}

class TodoListUpdated extends TodoEvent {
  final List<TodoWithTasksList> todosList;

  TodoListUpdated({required this.todosList});
  @override
  List<Object?> get props => [todosList];
}
