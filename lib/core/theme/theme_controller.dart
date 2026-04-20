// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_controller.g.dart';

class ThemeController = _ThemeController with _$ThemeController;

abstract class _ThemeController with Store {
  static const _key = 'isDark';

  final SharedPreferences _prefs;

  _ThemeController(this._prefs) : isDark = _prefs.getBool(_key) ?? false;

  @observable
  bool isDark;

  @action
  void toggleTheme() {
    isDark = !isDark;
    _prefs.setBool(_key, isDark);
  }
}
