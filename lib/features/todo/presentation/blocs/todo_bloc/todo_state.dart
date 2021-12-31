part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoListLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoWithTasksList> todoWithtasklist;

  TodoLoaded({
    required this.todoWithtasklist,
  });

  @override
  List<Object> get props => [todoWithtasklist];
}

class Error extends TodoState {
  final String message;

  Error({required this.message});
}
