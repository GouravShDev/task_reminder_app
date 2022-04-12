import 'package:flutter/material.dart';
import 'todo_add_edit_page.dart';
import '../widgets/app_drawer.dart';
import '../widgets/todo_panel.dart';

class TodoOverviewPage extends StatelessWidget {
  TodoOverviewPage({Key? key}) : super(key: key);

  static const route = '/todo-overview';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: mediaQuery.size.width * 0.3,
          child: Image.asset(
            'assets/image/app_title.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TodoAddEditPage.route).then((msg) {
            if (msg != null) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$msg'),
                  duration: Duration(milliseconds: 2000),
                ),
              );
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body: TodoPanel(),
    );
  }
}
