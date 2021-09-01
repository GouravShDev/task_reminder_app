part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class GetTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final ToDo todo;

  AddTodo(this.todo);
}

class ChangeTodoStatus extends TodoEvent {
  final ToDo todo;

  ChangeTodoStatus(this.todo);
}
