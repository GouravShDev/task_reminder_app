import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../theme/app_themes.dart';

class Settings {
  final SharedPreferences prefs;

  final ValueNotifier<bool> _confirmOnComp = ValueNotifier(false);
  final ValueNotifier<AppTheme> _appTheme = ValueNotifier(AppTheme.Light);

  // getters
  ValueNotifier<bool> get confirmOnComp => _confirmOnComp;
  ValueNotifier<AppTheme> get appTheme => _appTheme;

  Settings(this.prefs) {
    _intialize();
  }

  void _intialize() {
    _confirmOnComp.value =
        prefs.getBool(SETTING_CONFIRMATION_ON_COMP_TASK) ?? false;
    _appTheme.value = AppTheme.values[prefs.getInt(SETTING_THEME) ?? 0];
  }

  void toggleConfirmOnComp() {
    _confirmOnComp.value = !_confirmOnComp.value;
    prefs.setBool(SETTING_CONFIRMATION_ON_COMP_TASK, _confirmOnComp.value);
  }

  void setTheme(AppTheme appTheme) {
    _appTheme.value = appTheme;
    prefs.setInt(SETTING_THEME, appTheme.index);
  }
}
