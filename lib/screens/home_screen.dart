import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/todo_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(
        //   'To Do List',
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        // ),
        title: SizedBox(
          width: mediaQuery.size.width * 0.3,
          child: Image.asset(
            'assets/image/app_title.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEditToDoScreen.route);
        },
        // elevation: 0,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: ToDoPanel(),
      ),
    );
  }
}
