import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/settings_provider.dart';
import '../../theme/app_themes.dart';

class ZAnimatedButton extends StatefulWidget {
  final List<String> values;
  final ValueChanged<AppTheme> onToggleCallback;

  ZAnimatedButton({
    Key? key,
    required this.values,
    required this.onToggleCallback,
  }) : super(key: key);

  @override
  _ZAnimatedButtonState createState() => _ZAnimatedButtonState();
}

class _ZAnimatedButtonState extends State<ZAnimatedButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Theme.of(context);

    final proviedSettings = Provider.of<Settings>(context);
    return Container(
      width: width * .7,
      height: width * .10,
      child: Stack(
        children: [
          Container(
            width: width * .7,
            height: width * .10,
            decoration: ShapeDecoration(
                color:
                    themeProvider.textTheme.bodyText2!.color!.withOpacity(0.08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * .1)),
                shadows: [
                  BoxShadow(
                    color: themeProvider.textTheme.bodyText2!.color!
                        .withOpacity(0.08),
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.values.length,
                (index) => InkWell(
                  onTap: () {
                    final themeString = widget.values[index];
                    AppTheme theme;
                    if (themeString == 'Light') {
                      theme = AppTheme.Light;
                    } else if (themeString == 'Dark') {
                      theme = AppTheme.Dark;
                    } else {
                      theme = AppTheme.Black;
                    }
                    proviedSettings.setTheme(theme);
                    widget.onToggleCallback(theme);
                  },
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: width * .06),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                          fontSize: width * .045,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.textTheme.bodyText2!.color!),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: proviedSettings.appTheme,
            builder: (context, value, _) => AnimatedAlign(
              alignment: value == AppTheme.Light
                  ? Alignment.centerLeft
                  : value == AppTheme.Dark
                      ? Alignment.center
                      : Alignment.centerRight,
              duration: Duration(milliseconds: 350),
              curve: Curves.ease,
              child: Container(
                alignment: Alignment.center,
                width: width * .25,
                height: width * .10,
                decoration: ShapeDecoration(
                    color: themeProvider.canvasColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * .1)),
                    shadows: [
                      BoxShadow(
                          color: themeProvider.textTheme.bodyText2!.color!)
                    ]),
                child: Text(
                  value == AppTheme.Light
                      ? widget.values[0]
                      : value == AppTheme.Dark
                          ? widget.values[1]
                          : widget.values[2],
                  style: TextStyle(
                      fontSize: width * .045, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
