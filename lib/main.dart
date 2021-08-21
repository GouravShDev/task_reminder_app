import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'package:device_preview/device_preview.dart';

import '../screens/home_screen.dart';
import '../screens/setting_screen.dart';
import '../providers/todo_provider.dart';
import '../screens/add_edit_todo_screen.dart';
import 'theme_builder.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => MyApp(),
    enabled: !kReleaseMode,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ThemeBuilder(
        (context, _brightness, _uiColor, _textColor, materialColor) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ToDoList(),
          ),
          Provider<Settings>(create: (context) => Settings()),
        ],
        child: MaterialApp(
          title: 'To Do List',
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
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
