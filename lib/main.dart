import 'package:desafio_target/target_to_do.dart';
import 'package:flutter/material.dart';

import 'core/di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();

  runApp(const TargetToDoApp());
}
