import 'package:desafio_target/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  getIt.registerLazySingleton<AuthController>(() => AuthController());
}
