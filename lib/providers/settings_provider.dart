import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Settings {
  final ValueNotifier<bool> _confirmOnComp = ValueNotifier(false);
  ValueNotifier<bool> get confirmOnComp => _confirmOnComp;

  void intialize() async {
    final prefs = await SharedPreferences.getInstance();
    _confirmOnComp.value = prefs.getInt(SETTING_CONFIRMATION_ON_COMP_TASK) == 1;
  }

  void toggleConfirmOnComp() {
    _confirmOnComp.value = !_confirmOnComp.value;
  }
}
