// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeController on _ThemeController, Store {
  late final _$isDarkAtom = Atom(
    name: '_ThemeController.isDark',
    context: context,
  );

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  late final _$_ThemeControllerActionController = ActionController(
    name: '_ThemeController',
    context: context,
  );

  @override
  void toggleTheme() {
    final _$actionInfo = _$_ThemeControllerActionController.startAction(
      name: '_ThemeController.toggleTheme',
    );
    try {
      return super.toggleTheme();
    } finally {
      _$_ThemeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDark: ${isDark}
    ''';
  }
}
