import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/screens/home_screen.dart';
import 'package:todo_list_app/screens/setting_screen.dart';
import '../providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';
import './theme_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialColor = createMaterialColor(Color.fromRGBO(41, 79, 121, 1));
    return ThemeBuilder((context, _brightness, _uiColor, _textColor) {
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
                  headline6: TextStyle(
                      color: (_brightness == Brightness.dark)
                          ? materialColor.shade300
                          : materialColor.shade500)),
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

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
