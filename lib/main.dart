import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../screens/setting_screen.dart';
import '../providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';
import './theme_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        (context, _brightness, _uiColor, _textColor, materialColor) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ToDoList(),
          ),
        ],
        child: MaterialApp(
          title: 'To Do List',
          theme: ThemeData(
              canvasColor: _uiColor,
              brightness: _brightness,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: materialColor.shade500),
              textTheme: TextTheme(
                  bodyText1: TextStyle(color: _textColor),
                  bodyText2: TextStyle(color: _textColor),
                  headline6: TextStyle(
                    color: (_brightness == Brightness.dark)
                        ? materialColor.shade300
                        : materialColor.shade500,
                  )),
              primarySwatch: materialColor,
              appBarTheme: AppBarTheme(
                color: _uiColor,
                textTheme: TextTheme(headline6: TextStyle(color: _textColor)),
                iconTheme: IconThemeData(color: _textColor),
                elevation: 0,
              )),
          home: HomeScreen(),
          routes: {
            AddEditToDoScreen.route: (_) => AddEditToDoScreen(),
            SettingScreen.route: (_) => SettingScreen(),
          },
        ),
      );
    });
  }
}
