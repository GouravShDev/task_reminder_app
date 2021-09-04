import 'package:flutter/material.dart';
import '../../data/datasources/local/database/app_database.dart';
import 'package:moor/moor.dart' as mr;
import '../blocs/taskList_bloc/task_list_bloc.dart';
import 'package:provider/provider.dart';

class TaskListAddEditDialog extends StatefulWidget {
  final TasksList? currentTaskList;
  final Function? callback;
  const TaskListAddEditDialog({
    this.currentTaskList,
    this.callback,
    Key? key,
  }) : super(key: key);

  @override
  _TaskListAddEditDialogState createState() => _TaskListAddEditDialogState();
}

class _TaskListAddEditDialogState extends State<TaskListAddEditDialog> {
  final TextEditingController _addListTextController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _addListTextController.text = widget.currentTaskList?.name ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    _addListTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          (widget.currentTaskList == null) ? 'Create New List' : "Edit List"),
      content: TextField(
        controller: _addListTextController,
        decoration: InputDecoration(hintText: "Example: Study"),
      ),
      backgroundColor: Theme.of(context).cardColor,
      actions: [
        TextButton(
          onPressed: () {
            _addListTextController.clear();
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        // IconButton(
        //   icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: Icon(
        //     Icons.add,
        //     color: Theme.of(context).primaryColor,
        //   ),
        //   onPressed: () {},
        // ),
        TextButton(
          onPressed: () {
            context.read<TaskListBloc>().add(
                  AddTaskListEvent(
                    TasksListTableCompanion(
                      id: (widget.currentTaskList != null)
                          ? mr.Value(widget.currentTaskList!.id)
                          : mr.Value.absent(),
                      name: mr.Value(_addListTextController.text),
                    ),
                  ),
                );
            if (widget.callback != null)
              widget.callback!(_addListTextController.text);
            Navigator.pop(context);
            _addListTextController.clear();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
