import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../data/datasources/local/database/app_database.dart';
import '../blocs/taskList_bloc/task_list_bloc.dart';
import 'task_list_add_edit_dialog.dart';

class TasksListInput extends StatelessWidget {
  final Function(int) updateTaskListId;
  final int initValue;
  const TasksListInput(
    this.updateTaskListId, {
    Key? key,
    required this.initValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Add to a list',
            style:
                Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state) {
            if (state is TaskListsLoaded) {
              return TaskListDropDown(
                key: Key(state.taskList.length.toString()),
                tasksList: state.taskList,
                currentListId: initValue,
                updateTaskListId: updateTaskListId,
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}

class TaskListDropDown extends StatefulWidget {
  final List<TasksList> tasksList;
  final int currentListId;
  final Function(int) updateTaskListId;
  const TaskListDropDown({
    Key? key,
    required this.tasksList,
    required this.currentListId,
    required this.updateTaskListId,
  }) : super(key: key);

  @override
  _TaskListDropDownState createState() => _TaskListDropDownState();
}

class _TaskListDropDownState extends State<TaskListDropDown> {
  late String _selectedList;

  @override
  void initState() {
    setState(() {
      _selectedList = widget.tasksList
          .firstWhere((element) => element.id == widget.currentListId,
              orElse: () => TasksList(id: 0, name: "Default"))
          .name;
      widget.updateTaskListId(widget.currentListId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tasksListName =
        widget.tasksList.map((tl) => tl.name).toList();
    return Container(
      // padding: const EdgeInsets.only(left: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: _selectedList,
              isExpanded: true,
              iconEnabledColor: Theme.of(context).primaryColor,
              items: tasksListName
                  .map(
                    (String value) => DropdownMenuItem(
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 20),
                      ),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedList = newValue;
                  });
                  widget.updateTaskListId(widget.tasksList
                      .firstWhere((element) => element.name == _selectedList)
                      .id);
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TaskListAddEditDialog(
                    callback: (newListName) {
                      final currentTaskslist = widget.tasksList;
                      TasksList? td = currentTaskslist.firstWhereOrNull(
                          (element) => element.name == newListName);
                      if (td != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('List Already exist with same name'),
                          ),
                        );
                      }
                      // else {
                      //   widget.updateTaskListId(
                      //       currentTaskslist[currentTaskslist.length - 1].id +
                      //           1);
                      // }
                    },
                  );
                },
              );
            },
            icon: Icon(
              Icons.playlist_add,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
