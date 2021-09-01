import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/todo_bloc/todo_bloc.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../settings/provider/settings_provider.dart';
import '../../domain/entities/todo.dart';
import '../pages/todo_add_edit_page.dart';
import '../../../../injection_container.dart';

class TodoCard extends StatefulWidget {
  final ToDo todo;
  // final Function()
  const TodoCard(this.todo, {Key? key}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  var _isCompleted = false;

  void _taskCompleted() {
    setState(() {
      _isCompleted = !_isCompleted;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final bloc = context.read<TodoBloc>();
    Future.delayed(const Duration(milliseconds: 500), () {
      bloc.add(ChangeTodoStatus(widget.todo));
      // if (removedTodo.hasAlert == 1) {
      //   NotificationService.cancelScheduledNotification(widget.id);
      // }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Task Done'),
        duration: Duration(milliseconds: 2000),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            bloc.add(AddTodo(widget.todo));
            // if (removedTodo.hasAlert == 1) {
            //   NotificationService.scheduledNotification(
            //       id: removedTodo.id!, scheduledDate: removedTodo.due);
            // }
          },
        ),
      ));
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are You Sure?"),
          content: Text("Completed Task Great (^_^)"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context);
                _taskCompleted();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subtitleColor = (widget.todo.due.isAfter(DateTime.now()))
        ? Theme.of(context).primaryColor
        : Theme.of(context).errorColor;

    final proviedSettings = Provider.of<Settings>(context);
    return InkWell(
      onTap: () {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.hideCurrentSnackBar();
        Navigator.pushNamed(context, TodoAddEditPage.route,
                arguments: widget.todo)
            .then((msg) {
          if (msg != null) {
            scaffold.hideCurrentSnackBar();
            scaffold.showSnackBar(
              SnackBar(
                content: Text('$msg'),
                duration: Duration(milliseconds: 2000),
              ),
            );
          }
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        transform: (_isCompleted)
            ? (Matrix4.identity()
              ..translate(size.width * 1)
              ..scale(0.9))
            : (Matrix4.identity()),
        margin:
            EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.all(4),
          leading: ValueListenableBuilder<bool>(
            valueListenable: proviedSettings.confirmOnComp,
            builder: (context, value, _) => IconButton(
              icon: (_isCompleted
                  ? Icon(
                      Icons.task_alt_rounded,
                    )
                  : Icon(Icons.circle_outlined)),
              onPressed: () {
                if (value) {
                  _showAlertDialog();
                } else {
                  _taskCompleted();
                }
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: size.width * 0.04),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 4),
                        child: Icon(
                          Icons.access_time_outlined,
                          size: 12,
                          color: subtitleColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          locator<DateFormatter>().formatDate(widget.todo.due),
                          style: TextStyle(color: subtitleColor),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4, right: 4),
                    child: Text(
                      'Default',
                      style: TextStyle(color: subtitleColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
