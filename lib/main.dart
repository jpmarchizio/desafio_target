import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/features/notes/data/adapters/note_adapter.dart';
import 'package:desafio_target/features/notes/data/datasources/note_local_datasource.dart';
import 'package:desafio_target/firebase_options.dart';
import 'package:desafio_target/target_to_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null && currentUser.isAnonymous) {
    await FirebaseAuth.instance.signOut();
  }
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await NoteLocalDataSource.init();
  final prefs = await SharedPreferences.getInstance();
  await setupInjector(prefs);

  runApp(const TargetToDoApp());
}
