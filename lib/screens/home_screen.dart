import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/screens/add_edit_todo_screen.dart';
import 'package:todo_list_app/widgets/app_drawer.dart';
import '../widgets/todo_card.dart';
import '../providers/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();
  @override
  Widget build(BuildContext context) {
    // get ToDoList from the provider
    final todosList = Provider.of<ToDoList>(context).todos;
    // sort the list by date
    todosList.sort((a, b) => a.date.compareTo(b.date));
    // .sort((a, b) => a.date.compareTo(b.date));

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
        elevation: 0,
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: Text(
              "Today's Tasks",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 4),
              itemCount: todosList.length,
              itemBuilder: (context, index) {
                return ToDoCard(
                  todosList[index].id!,
                  todosList[index].name,
                  todosList[index].date,
                  key: Key(todosList[index].id.toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
