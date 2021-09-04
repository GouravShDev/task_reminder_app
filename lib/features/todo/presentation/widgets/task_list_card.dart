import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/datasources/local/database/app_database.dart';
import '../blocs/taskList_bloc/task_list_bloc.dart';
import 'task_list_add_edit_dialog.dart';

class TasksListCard extends StatelessWidget {
  final TasksList tasksList;
  const TasksListCard({required this.tasksList, Key? key}) : super(key: key);

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are You Sure?"),
          content: Text("All the Todos from this list will be deleted"),
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

                context
                    .read<TaskListBloc>()
                    .add(DeleteTaskListEvent(tasksList));
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
    final iconColor = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.all(4),
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.format_list_bulleted_outlined,
            color: iconColor,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Text(
            tasksList.name,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: size.width * 0.04),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return TaskListAddEditDialog(
                        currentTaskList: tasksList,
                      );
                    });
              },
              icon: Icon(
                Icons.edit,
                color: iconColor,
              ),
            ),
            IconButton(
              onPressed: () {
                _showAlertDialog(context);
              },
              icon: Icon(
                Icons.delete_forever,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
