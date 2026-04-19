import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/firebase_options.dart';
import 'package:desafio_target/target_to_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupInjector();

  runApp(const TargetToDoApp());
}
