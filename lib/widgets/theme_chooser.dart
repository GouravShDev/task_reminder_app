import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/animatedButton.dart';
import '../theme_builder.dart';
import '../Constants.dart';

class ThemeChooser extends StatelessWidget {
  const ThemeChooser({Key? key}) : super(key: key);

  void _changeTheme(
      {required String themeName, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    if (themeName == 'light') {
      ThemeBuilder.of(context)!.changeTheme(CustomTheme.light);
      // Storing Selection in sharePref
      prefs.setInt(SETTING_THEME, 0);
    } else if (themeName == 'dark') {
      ThemeBuilder.of(context)!.changeTheme(CustomTheme.dark);
      // Storing Selection in sharePref
      prefs.setInt(SETTING_THEME, 1);
    } else {
      ThemeBuilder.of(context)!.changeTheme(CustomTheme.black);
      // Storing Selection in sharePref
      prefs.setInt(SETTING_THEME, 2);
    }
  }

  /*
  * Logic for getting different Icon
  * according to current theme
  */
  IconData getIcon(String theme) {
    if (theme == 'light') {
      return Icons.wb_sunny;
    } else if (theme == 'dark') {
      return Icons.nights_stay_outlined;
    } else {
      return Icons.nightlight_round;
    }
  }

  _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade800,
    );
  }

  _buildThemeIcon(double height, dynamic theme) {
    if (theme.isLightTheme()) {
      return Icon(
        Icons.wb_sunny_sharp,
        size: height * 0.10,
      );
    } else if (theme.isDarkTheme()) {
      return Icon(
        Icons.nights_stay_outlined,
        size: height * 0.10,
      );
    } else {
      return Icon(
        Icons.nights_stay,
        size: height * 0.10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeBuilder.of(context);
    final mediaQuery = MediaQuery.of(context);
    final _height = mediaQuery.size.height;
    final _width = mediaQuery.size.width;
    return Column(
      children: [
        SizedBox(
          height: _height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose Your Theme",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: _width * 0.045),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildThemeIcon(_height, _theme),
        ),
        ZAnimatedButton(
          values: ['light', 'dark', 'black'],
          onToggleCallback: (theme) {
            _changeTheme(themeName: theme, context: context);
          },
        ),
        SizedBox(
          height: _height * 0.025,
        ),
        _buildDivider(),
      ],
    );
  }
}
