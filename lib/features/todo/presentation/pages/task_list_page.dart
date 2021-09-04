import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/local/database/app_database.dart';
import '../blocs/taskList_bloc/task_list_bloc.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_widget.dart';
import '../widgets/task_list_add_edit_dialog.dart';
import '../widgets/task_list_card.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  static const route = '/task-list';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks List",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: mediaQuery.size.width * 0.05,
                fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TaskListAddEditDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state) {
            if (state is TaskListInitial) {
              return LoadingWidget();
            } else if (state is TaskListError) {
              return ErrorMessage(errorMessage: state.message);
            } else if (state is TaskListsLoaded) {
              final todosList = state.taskList;
              return _buildBody(todosList, mediaQuery);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(List<TasksList> tasksList, MediaQueryData mediaQuery) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        margin: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.02, vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: 5, bottom: 10),
          itemCount: tasksList.length,
          itemBuilder: (BuildContext context, int index) {
            final tl = tasksList[index];
            if (tl.name != "Default") {
              return TasksListCard(tasksList: tl);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
