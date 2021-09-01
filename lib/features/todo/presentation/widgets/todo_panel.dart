import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/utils/todo_filter.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import '../blocs/todo_bloc/todo_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../injection_container.dart';
import 'error_message.dart';
import 'intial_message.dart';
import 'loading_widget.dart';
import 'todo_card.dart';

class TodoPanel extends StatefulWidget {
  const TodoPanel({Key? key}) : super(key: key);

  @override
  _TodoPanelState createState() => _TodoPanelState();
}

class _TodoPanelState extends State<TodoPanel> {
  Widget _buildTodoTile(
      {required String title, required List<TodoWithTasksList> todos}) {
    if (todos.isEmpty) return Container();
    final Color borderColor = (title.contains('Overdue'))
        ? Theme.of(context).errorColor
        : Theme.of(context).primaryColor;
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              horizontal: mediaQuery.size.width * 0.03, vertical: 20),
          // margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
          ),
          // child: TodoListWidget(todos),

          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.only(top: 5, bottom: 10),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoCard(
                todos[index],
                key: Key(todos[index].todo.id.toString()),
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
                  .copyWith(fontWeight: FontWeight.w600, color: borderColor),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context).add(GetTodos());
    return SafeArea(child: BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoInitial || state is Loading) {
          return LoadingWidget();
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Error) {
          return ErrorMessage(errorMessage: state.message);
        } else if (state is Loaded) {
          final todosList = state.todoWithtasklist;
          return (todosList.isNotEmpty)
              ? _buildBody(todosList)
              : InitialMessage();
        } else {
          return Container();
        }
      },
    ));
  }

  Widget _buildBody(List<TodoWithTasksList> todosList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            _buildTodoTile(
                title: kOverdueTodo,
                todos:
                    locator<TodoFilter>().filterTodos(todosList, kOverdueTodo)),
            _buildTodoTile(
                title: kTodayTodo,
                todos:
                    locator<TodoFilter>().filterTodos(todosList, kTodayTodo)),
            _buildTodoTile(
                title: kUpcomingTodo,
                todos: locator<TodoFilter>()
                    .filterTodos(todosList, kUpcomingTodo)),
          ],
        ),
      ),
    );
  }
}
