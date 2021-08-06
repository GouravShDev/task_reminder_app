import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Constants.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Brightness brightness,
      Color uiColor, Color textColor, MaterialColor materialColor) builder;

  ThemeBuilder(this.builder);

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();

  static _ThemeBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeBuilderState>();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  // Initializing Theme as Light by Default
  CustomTheme _currentTheme = CustomTheme.light;
  Brightness brightness = Brightness.light;
  Color uiColor = Color.fromRGBO(238, 238, 238, 1);
  Color textColor = Colors.black;
  final materialColor = createMaterialColor(Color.fromRGBO(48, 97, 183, 1));
  /*
  * Read the int value Stored in SharedPreferences for theme
  *
  * THEME : Value
  * Light = 0
  * Dark = 1
  * Black = 2
  *
  */
  Future<CustomTheme> _getThemeFromSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    final themeNo = prefs.getInt(SETTING_THEME);
    if (themeNo == null || themeNo == 0) {
      return CustomTheme.dark;
    }
    if (themeNo == 1) {
      return CustomTheme.dark;
    } else {
      return CustomTheme.black;
    }
  }

  @override
  void initState() {
    super.initState();
    // Changing Theme according to value stored in SharePreference
    _getThemeFromSharePref().then((theme) {
      if (_currentTheme != theme) {
        setState(() {
          _currentTheme = theme;
          _setThemeColors(_currentTheme);
        });
      }
    });
  }

/*
* Setting theme Color variable for each theme like textColor
*/

  void _setThemeColors(CustomTheme theme) {
    switch (theme) {
      case CustomTheme.light:
        brightness = Brightness.light;
        // uiColor = Colors.white;
        uiColor = Color.fromRGBO(238, 238, 238, 1);
        textColor = Colors.black;
        _currentTheme = CustomTheme.light;
        break;
      case CustomTheme.dark:
        brightness = Brightness.dark;
        uiColor = Color.fromRGBO(33, 33, 33, 1);
        // textColor = Colors.white;
        textColor = Color.fromRGBO(238, 238, 238, 1);
        // textColor = Colors.red;
        _currentTheme = CustomTheme.dark;
        break;
      case CustomTheme.black:
        brightness = Brightness.dark;
        uiColor = Colors.black;
        textColor = Color.fromRGBO(238, 238, 238, 1);
        _currentTheme = CustomTheme.black;
        break;
    }
  }

  bool isLightTheme() {
    return _currentTheme == CustomTheme.light;
  }

  bool isDarkTheme() {
    return _currentTheme == CustomTheme.dark;
  }

  bool isBlackTheme() {
    return _currentTheme == CustomTheme.black;
  }

  void changeTheme(CustomTheme selectedTheme) {
    setState(() {
      _setThemeColors(selectedTheme);
    });
  }

  CustomTheme getCurrentTheme() {
    return _currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
        context, brightness, uiColor, textColor, materialColor);
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
