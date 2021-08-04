import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/todo_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> _dueTodos = [];
  List<ToDo> _todayTodos = [];
  List<ToDo> _upcomingTodos = [];

  void _distTodos(List<ToDo> todos) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    todos.forEach((todo) {
      if (todo.date.isBefore(now)) {
        _dueTodos.add(todo);
      } else if (todo.date.isAfter(today) && todo.date.isBefore(tomorrow)) {
        _todayTodos.add(todo);
      } else {
        _upcomingTodos.add(todo);
      }
    });
    // sort the list by date
    _dueTodos.sort((a, b) => a.date.compareTo(b.date));
    _todayTodos.sort((a, b) => a.date.compareTo(b.date));
    _upcomingTodos.sort((a, b) => a.date.compareTo(b.date));
    // set expandTile to open or not
    // if list empty then set to false
  }

  @override
  Widget build(BuildContext context) {
    // get ToDoList from the provider
    // .sort((a, b) => a.date.compareTo(b.date));
    final todoList = Provider.of<ToDoList>(context).todos;

    // Distribute the todos into the 3 lists
    // dueTodos, todayTodos, upcomingTodos
    _distTodos(todoList);

    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(
        //   'To Do List',
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        // ),
        title: SizedBox(
          width: mediaQuery.size.width * 0.3,
          child: Image.asset(
            'assets/image/app_title.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEditToDoScreen.route);
        },
        // elevation: 0,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: ToDoPanel(_dueTodos, _todayTodos, _upcomingTodos),
      ),
    );
  }
}
