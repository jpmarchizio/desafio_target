// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'theme_controller.g.dart';

class ThemeController = _ThemeController with _$ThemeController;

abstract class _ThemeController with Store {
  @observable
  bool isDark = false;

  @action
  void toggleTheme() => isDark = !isDark;
}
