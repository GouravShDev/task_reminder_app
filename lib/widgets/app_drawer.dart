import 'package:flutter/material.dart';
import 'package:todo_list_app/screens/setting_screen.dart';

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
            ListTile(
              leading: Icon(Icons.assignment_outlined),
              title: Text(
                'Task List',
                style: listTileTextStyle,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings', style: listTileTextStyle),
              onTap: () {
                Navigator.pushNamed(context, SettingScreen.route);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About', style: listTileTextStyle),
              onTap: () {
                // Navigator.pushNamed(context, AboutScreen.routeName);
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.mail_rounded),
            //   title: Text(
            //     'Contact',
            //     style: TextStyle(
            //       fontSize: 22,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
