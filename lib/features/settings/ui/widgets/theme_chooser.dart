import 'package:flutter/material.dart';
import '../../provider/settings_provider.dart';
import 'package:provider/provider.dart';
import '../../theme/app_themes.dart';
import '../../theme/bloc/theme_bloc.dart';
import 'animated_button.dart';

class ThemeChooser extends StatefulWidget {
  const ThemeChooser({Key? key}) : super(key: key);

  @override
  _ThemeChooserState createState() => _ThemeChooserState();
}

class _ThemeChooserState extends State<ThemeChooser> {
  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade800,
    );
  }

  Icon _buildThemeIcon(double height, AppTheme theme) {
    if (theme == AppTheme.Light) {
      return Icon(
        Icons.wb_sunny_sharp,
        size: height * 0.10,
      );
    } else if (theme == AppTheme.Dark) {
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
    final mediaQuery = MediaQuery.of(context);
    final _height = mediaQuery.size.height;
    final _width = mediaQuery.size.width;
    final proviedSettings = Provider.of<Settings>(context);
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
          child: _buildThemeIcon(_height, proviedSettings.appTheme.value),
        ),
        ZAnimatedButton(
          values: ['Light', 'Dark', 'Black'],
          onToggleCallback: (AppTheme theme) {
            proviedSettings.setTheme(theme);
            context.read<ThemeBloc>().add(ThemeChanged(theme: theme));
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
