import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/Constants.dart';

import '../theme_builder.dart';
import '../widgets/todo_card.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class ToDoPanel extends StatefulWidget {
  final List<ToDo> dueTodos;
  final List<ToDo> todayTodos;
  final List<ToDo> upcomingTodos;
  const ToDoPanel(this.dueTodos, this.todayTodos, this.upcomingTodos,
      {Key? key})
      : super(key: key);

  @override
  _ToDoPanelState createState() => _ToDoPanelState();
}

class _ToDoPanelState extends State<ToDoPanel> {
  late List<bool> _isOpen;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      Provider.of<ToDoList>(context, listen: false).initialize();

      _isInit = true;
    }
    super.didChangeDependencies();
  }

  void _updateExpandedFlags() {
    print('called');
    _isOpen = [
      widget.dueTodos.length > 0,
      widget.todayTodos.length > 0,
      widget.upcomingTodos.length > 0
    ];
  }

  // void _distTodos(List<ToDo> todos) {
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);
  //   final tomorrow = DateTime(now.year, now.month, now.day + 1);

  //   todos.forEach((todo) {
  //     if (todo.date.isBefore(now)) {
  //       dueTodos.add(todo);
  //     } else if (todo.date.isAfter(today) && todo.date.isBefore(tomorrow)) {
  //       todayTodos.add(todo);
  //     } else {
  //       upcomingTodos.add(todo);
  //     }
  //   });
  //   // sort the list by date
  //   dueTodos.sort((a, b) => a.date.compareTo(b.date));
  //   todayTodos.sort((a, b) => a.date.compareTo(b.date));
  //   upcomingTodos.sort((a, b) => a.date.compareTo(b.date));
  //   // set expandTile to open or not
  //   // if list empty then set to false
  // }

  ExpansionPanel _getTodoTile(List<ToDo> todos, String title, int index) {
    final themeProvider = ThemeBuilder.of(context);

    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: (themeProvider!.getCurrentTheme() == CustomTheme.black)
          ? themeProvider.textColor.withAlpha(20)
          : themeProvider.uiColor,
      // backgroundColor: themeProvider!.textColor.withAlpha(20),
      isExpanded: _isOpen[index],
      headerBuilder: (context, isExpanded) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: (index != 0) // Check if it due todos
                    ? Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w600)
                    : Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade600),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (index != 0)
                      ? themeProvider.materialColor.shade400
                      : Colors.red.shade600,
                ),
                child: Text(todos.length.toString()),
              )
            ],
          )),
      // body: Text('k'),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 4),
        itemCount: todos.length,
        itemBuilder: (context, i) {
          return ToDoCard(
            todos[i].id!,
            todos[i].name,
            todos[i].date,
            key: Key(todos[i].id.toString()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build Runs');
    _updateExpandedFlags();
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 4.0, right: 4.0),
      child: Column(
        children: [
          ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.only(top: 10),
              animationDuration: Duration(milliseconds: 500),
              dividerColor:
                  Theme.of(context).textTheme.bodyText1!.color!.withAlpha(20),
              // dividerColor: Colors.transparent,
              elevation: 0,
              children: [
                _getTodoTile(widget.dueTodos, 'Due', 0),
                _getTodoTile(widget.todayTodos, 'Today', 1),
                _getTodoTile(widget.upcomingTodos, 'Upcoming', 2),
              ],
              expansionCallback: (panelIndex, isOpen) {
                setState(() {
                  _isOpen[panelIndex] = !isOpen;
                });
              }),
        ],
      ),
    );
  }
}
