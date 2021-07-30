import 'package:flutter/material.dart';
import 'add_edit_todo_screen.dart';
import '../screens/home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _screenlists = <Widget>[
    HomeScreen(),
    Text('TasksList'),
    // AddToDoScreen(),
    Text('Index 3: Settings'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screenlists.elementAt(_selectedIndex),
      ),
      floatingActionButton: (_selectedIndex == 0)
          ? FloatingActionButton(
              onPressed: () {
                print("ok");
                Navigator.pushNamed(context, AddEditToDoScreen.route);
              },
              elevation: 0,
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor:
        //     Theme.of(context).textTheme.bodyText1!.color!.withAlpha(2),
        backgroundColor: Theme.of(context).cardColor.withOpacity(1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.red,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp),
            label: 'Profile',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
