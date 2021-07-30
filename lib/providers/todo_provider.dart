import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/models/todo.dart';

class ToDoList with ChangeNotifier {
  final List<ToDo> _todos = [
    ToDo('1', 'Android Development', DateTime.now()),
    ToDo('2', 'Web Development', DateTime.now()),
    ToDo('3', 'AI', DateTime.now()),
  ];

  // getter for list of todos
  List<ToDo> get todos => [..._todos];

  void addItem(String name, DateTime date, {String? productId}) {
    if (productId == null) {
      _todos.add(ToDo(DateTime.now().toString(), name, date));
    } else {
      // TODO: Implement Edit logic
    }
    notifyListeners();
  }
}
