import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  final String title;
  const ToDoCard(this.title);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        leading: Icon(Icons.circle_outlined),
        minLeadingWidth: size.width * 0.01,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: size.width * 0.04),
        ),
      ),
    );
  }
}
