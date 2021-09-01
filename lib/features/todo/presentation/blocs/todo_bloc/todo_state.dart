part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class Loading extends TodoState {}

class Loaded extends TodoState {
  final List<ToDo> todos;

  Loaded({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];
}

class Error extends TodoState {
  final String message;

  Error({required this.message});
}
