import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/presentation/pages/task_list_page.dart';
import '../../../settings/ui/pages/Settings_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listTileTextStyle = TextStyle(
      fontSize: 20,
    );
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width * 0.6,
      child: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(colors: <Color>[
                //       Colors.red.shade400,
                //       Colors.yellowAccent.shade400,
                //     ],)
                // ),
                child: FittedBox(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).canvasColor,
                radius: 10,
                backgroundImage: AssetImage("assets/image/logo.png"),
              ),
              fit: BoxFit.fitHeight,
            )),
            SizedBox(
              height: 18,
            ),
            // ListTile(
            //   leading: Icon(Icons.assignment_outlined),
            //   title: Text(
            //     'Task List',
            //     style: listTileTextStyle,
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text('Lists', style: listTileTextStyle),
              onTap: () {
                Navigator.pushNamed(context, TaskListPage.route);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings', style: listTileTextStyle),
              onTap: () {
                Navigator.pushNamed(context, SettingsPage.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
