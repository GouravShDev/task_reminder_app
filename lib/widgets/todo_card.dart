import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';

class ToDoCard extends StatefulWidget {
  final int id;
  final String title;
  final DateTime date;
  const ToDoCard(this.id, this.title, this.date, {Key? key}) : super(key: key);

  @override
  _ToDoCardState createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  var _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    print(widget.date);
    final size = MediaQuery.of(context).size;
    final todoProvider = Provider.of<ToDoList>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddEditToDoScreen.route,
            arguments: widget.id);
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
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).textTheme.bodyText2!.color!.withAlpha(15)
              : Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: ListTile(
          leading: GestureDetector(
              onTap: () {
                setState(() {
                  _isCompleted = !_isCompleted;
                });
                // Show snackbar for undo action.

                Future.delayed(const Duration(milliseconds: 500), () {
                  final removedTodo = todoProvider.removeItem(widget.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Task Done'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // todoProvider.addItemWithId(removedTodo.id!,
                        //     removedTodo.name, removedTodo.date);
                        todoProvider.addUpdateItem(
                            removedTodo.name, removedTodo.date);
                      },
                    ),
                  ));
                });
              },
              child: (_isCompleted
                  ? Icon(
                      Icons.task_alt_rounded,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(Icons.circle_outlined))),
          minLeadingWidth: size.width * 0.01,
          title: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: size.width * 0.04),
          ),
        ),
      ),
    );
  }
}
