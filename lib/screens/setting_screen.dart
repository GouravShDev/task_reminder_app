import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/animatedButton.dart';
import '../theme_builder.dart';
import '../Constants.dart';

class SettingScreen extends StatelessWidget {
  static const route = '/setting';
  /*
  * This method change according to user selection
  */

  void _changeTheme(
      {required String themeName, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    if (themeName == 'light') {
      ThemeBuilder.of(context)!.changeTheme(CustomTheme.light);
      // Storing Selection in sharePref
      prefs.setInt(baseTheme, 0);
    } else if (themeName == 'dark') {
      ThemeBuilder.of(context)!.changeTheme(CustomTheme.dark);
      // Storing Selection in sharePref
      prefs.setInt(baseTheme, 1);
    } else {
      ThemeBuilder.of(context)!.changeTheme(CustomTheme.black);
      // Storing Selection in sharePref
      prefs.setInt(baseTheme, 2);
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
    final _width = mediaQuery.size.width;
    final _height = mediaQuery.size.height;
    bool _isChecked = false;
    final subTextStyles = TextStyle(fontSize: _width * 0.035);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: mediaQuery.size.width * 0.05,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: _height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose Your Style",
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _buildCustomBox(
          //         themeName: 'light', ctx: context, themeBuilderState: _theme),
          //     _buildCustomBox(
          //         themeName: 'dark', ctx: context, themeBuilderState: _theme),
          //     _buildCustomBox(
          //         themeName: 'black', ctx: context, themeBuilderState: _theme),
          //   ],
          // ),
          SizedBox(
            height: _height * 0.025,
          ),
          _buildDivider(),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: _width * 0.03, vertical: 30),
            alignment: Alignment.topLeft,
            child: Text(
              'General',
              style: Theme.of(context).textTheme.headline6!,
            ),
          ),

          Container(
            margin:
                EdgeInsets.symmetric(horizontal: _width * 0.06, vertical: 4),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Show Confirmation on Complete Task',
                    style: subTextStyles),
                IconButton(
                  icon: Icon(Icons.task_alt_outlined),
                  // icon: (_isChecked
                  //     ? Icon(
                  //         Icons.task_alt_rounded,
                  //       )
                  //     : Icon(Icons.circle_outlined)),
                  onPressed: () {},
                  color: Theme.of(context).textTheme.headline6!.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
