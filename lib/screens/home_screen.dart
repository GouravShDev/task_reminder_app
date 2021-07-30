import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/todo_card.dart';
import '../providers/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();
  @override
  Widget build(BuildContext context) {
    final todosList = Provider.of<ToDoList>(context).todos;
    final mediaQuery = MediaQuery.of(context);
    final headingTextStyle = TextStyle(
        fontSize: mediaQuery.size.width * 0.06, fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: mediaQuery.padding.top + 16,
              left: 16,
              right: 16,
              bottom: 16),
          child: Text(
            "Today's Tasks",
            style: headingTextStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4),
            itemCount: todosList.length,
            itemBuilder: (context, index) {
              return ToDoCard(todosList[index].title);
            },
          ),
        )
      ],
    );
  }
}
