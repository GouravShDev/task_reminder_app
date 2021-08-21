import 'package:flutter/cupertino.dart';
import '../utils/todo_database.dart';
import '../models/todo.dart';

class ToDoList with ChangeNotifier {
  List<ToDo> _todos = [
    // ToDo(1, 'Android Development', DateTime.parse("1969-07-20 20:18:04Z")),
    // ToDo('2', 'Web Development', DateTime.now()),
    // ToDo('3', 'AI', DateTime.now()),
  ];
  ToDoDatabase _databaseHelper = ToDoDatabase();

  initialize() async {
    _todos = await _databaseHelper.getTaskMapList();
    _todos.forEach((element) {
      print(element.name);
    });
    notifyListeners();
  }

  // getter for list of todos
  List<ToDo> get todos {
    return [..._todos];
  }

  Future<int> addUpdateItem(String name, DateTime date, int hasAlert,
      {int? id}) async {
    int taskId;
    if (id == null) {
      final todo = await _databaseHelper
          .insertTask(ToDo(name: name, due: date, hasAlert: hasAlert));
      _todos.add(todo);
      taskId = todo.id!;
    } else {
      final todo = ToDo(name: name, due: date, id: id, hasAlert: hasAlert);
      await _databaseHelper.updateTask(todo);
      final index = _todos.indexWhere((element) => element.id == id);
      _todos[index] = todo;
      taskId = id;
    }
    notifyListeners();
    return taskId;
  }

  ToDo findById(int id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  ToDo removeItem(int id) {
    final index = _todos.indexWhere((element) => element.id == id);
    final removedItem = _todos[index];
    _todos.removeAt(index);
    _databaseHelper.deleteTask(id);
    notifyListeners();
    return removedItem;
  }
}
