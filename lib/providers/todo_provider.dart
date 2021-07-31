import 'package:flutter/cupertino.dart';
import '../models/todo.dart';

class ToDoList with ChangeNotifier {
  final List<ToDo> _todos = [
    ToDo('1', 'Android Development', DateTime.parse("1969-07-20 20:18:04Z")),
    ToDo('2', 'Web Development', DateTime.now()),
    ToDo('3', 'AI', DateTime.now()),
  ];

  // getter for list of todos
  List<ToDo> get todos => [..._todos];

  void addUpdateItem(String name, DateTime date, {String? productId}) {
    if (productId == null) {
      _todos.add(ToDo(DateTime.now().toString(), name, date));
    } else {
      final index = _todos.indexWhere((element) => element.id == productId);
      _todos[index] = ToDo(productId, name, date);
    }
    notifyListeners();
  }

  ToDo findById(id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  void removeItem(String id) {
    _todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
