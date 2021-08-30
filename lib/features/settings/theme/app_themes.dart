import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
  Black,
}

const Color lightThemeColor = Color.fromRGBO(238, 238, 238, 1);
const Color darkThemeColor = Color.fromRGBO(33, 33, 33, 1);
const Color darkThemeCardColor = Color.fromRGBO(40, 40, 40, 1);
const Color blackThemeColor = Colors.black;
const Color blackThemeCardColor = Color.fromRGBO(31, 31, 31, 1);

final MaterialColor appSwatch =
    createMaterialColor(Color.fromRGBO(48, 97, 183, 1));

final Map<AppTheme, ThemeData> appThemeData = {
  // Light Theme Data
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    canvasColor: lightThemeColor,
    textTheme: TextTheme(
        headline6: TextStyle(
      color: appSwatch.shade500,
    )),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appSwatch.shade500),
    primarySwatch: appSwatch,
    primaryColor: appSwatch.shade500,
    appBarTheme: AppBarTheme(
      color: lightThemeColor,
      elevation: 0,
      iconTheme: IconThemeData(color: appSwatch.shade600),
    ),
  ),
  // Dark Theme Data
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    canvasColor: darkThemeColor,
    textTheme: TextTheme(
        headline6: TextStyle(
      color: appSwatch.shade500,
    )),
    primarySwatch: appSwatch,
    primaryColor: appSwatch.shade300,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appSwatch.shade500),
    appBarTheme: AppBarTheme(
      color: darkThemeColor,
      elevation: 0,
      iconTheme: IconThemeData(color: appSwatch.shade600),
    ),
    cardColor: darkThemeCardColor,
  ),
  // Black Theme Data
  AppTheme.Black: ThemeData(
    brightness: Brightness.dark,
    canvasColor: blackThemeColor,
    textTheme: TextTheme(
        headline6: TextStyle(
      color: appSwatch.shade300,
    )),
    primarySwatch: appSwatch,
    primaryColor: appSwatch.shade500,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appSwatch.shade500),
    appBarTheme: AppBarTheme(
      color: blackThemeColor,
      elevation: 0,
      iconTheme: IconThemeData(color: appSwatch.shade600),
    ),
    cardColor: blackThemeCardColor,
  ),
};

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
