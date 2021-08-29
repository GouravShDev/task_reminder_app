import 'package:flutter/material.dart';
import '../../provider/settings_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/theme_chooser.dart';

class SettingsPage extends StatefulWidget {
  static const route = '/setting';
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _width = mediaQuery.size.width;
    final subTextStyles = TextStyle(fontSize: _width * 0.035);
    final providedSettings = Provider.of<Settings>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: mediaQuery.size.width * 0.05,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          ThemeChooser(),
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
                ValueListenableBuilder<bool>(
                    valueListenable: providedSettings.confirmOnComp,
                    builder: (context, value, _) {
                      print('IconsButton Rebuilds');
                      return IconButton(
                        // icon: Icon(Icons.task_alt_outlined),
                        icon: (value
                            ? Icon(
                                Icons.task_alt_rounded,
                              )
                            : Icon(Icons.circle_outlined)),
                        onPressed: () {
                          providedSettings.toggleConfirmOnComp();
                        },
                        color: Theme.of(context).textTheme.headline6!.color,
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
