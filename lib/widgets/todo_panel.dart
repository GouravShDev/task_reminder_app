import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/Constants.dart';

import '../theme_builder.dart';
import '../widgets/todo_card.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class ToDoPanel extends StatefulWidget {
  const ToDoPanel({Key? key}) : super(key: key);

  @override
  _ToDoPanelState createState() => _ToDoPanelState();
}

class _ToDoPanelState extends State<ToDoPanel> {
  late List<ToDo> _dueTodos;
  late List<ToDo> _todayTodos;
  late List<ToDo> _upcomingTodos;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      Provider.of<ToDoList>(context, listen: false).initialize();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  void _distTodos(List<ToDo> todos) {
    _dueTodos = [];
    _todayTodos = [];
    _upcomingTodos = [];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    todos.forEach((todo) {
      if (todo.due.isBefore(now)) {
        _dueTodos.add(todo);
      } else if (todo.due.isAfter(today) && todo.due.isBefore(tomorrow)) {
        _todayTodos.add(todo);
      } else {
        _upcomingTodos.add(todo);
      }
    });
    // sort the list by date
    // _dueTodos.sort((a, b) => a.due.compareTo(b.due));
    // _todayTodos.sort((a, b) => a.due.compareTo(b.due));
    // _upcomingTodos.sort((a, b) => a.due.compareTo(b.due));
    // set expandTile to open or not
    // if list empty then set to false
  }

  Widget _buildTodoTile({required String title, required List<ToDo> todos}) {
    final mediaQuery = MediaQuery.of(context);
    final color = (title.contains('OverDue'))
        ? Theme.of(context).errorColor
        : ThemeBuilder.of(context)!.materialColor.shade400;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              horizontal: mediaQuery.size.width * 0.03, vertical: 20),
          // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
          ),

          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.only(top: 5, bottom: 10),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ToDoCard(
                todos[index].id!,
                todos[index].name,
                todos[index].due,
                key: Key(todos[index].id.toString()),
              );
            },
          ),
        ),
        Positioned(
          left: 30,
          top: 12,
          child: Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: Theme.of(context).canvasColor,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w600, color: color),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build Runs');
    // get ToDoList from the provider
    final todoList = Provider.of<ToDoList>(context).todos;

    // Distribute the todos into the 3 lists
    // dueTodos, todayTodos, upcomingTodos
    _distTodos(todoList);
    return Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 4.0, right: 4.0),
        child: Column(
          children: [
            if (_dueTodos.length > 0)
              _buildTodoTile(title: "OverDue Task", todos: _dueTodos),
            if (_todayTodos.length > 0)
              _buildTodoTile(title: "Today's Task", todos: _todayTodos),
            if (_upcomingTodos.length > 0)
              _buildTodoTile(title: "Upcoming Task", todos: _upcomingTodos),
          ],
        ));
  }
}
