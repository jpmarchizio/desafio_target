import 'package:desafio_target/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:desafio_target/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:desafio_target/features/auth/domain/repositories/auth_repository.dart';
import 'package:desafio_target/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:desafio_target/features/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:desafio_target/features/auth/presentation/controllers/login_controller.dart';
import 'package:desafio_target/features/auth/presentation/controllers/signup_controller.dart';
import 'package:desafio_target/features/notes/presentation/controllers/note_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  // Auth
  // Services
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(FirebaseAuth.instance));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()));

  // Use Cases
  getIt.registerLazySingleton<SignInUseCase>(() => SignInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignInAnonymouslyUseCase>(() => SignInAnonymouslyUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SendPasswordResetEmailUseCase>(() => SendPasswordResetEmailUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(getIt<AuthRepository>()));

  // Controllers
  getIt.registerFactory<LoginController>(
    () => LoginController(getIt<SignInUseCase>(), getIt<SignInAnonymouslyUseCase>()),
  );
  getIt.registerFactory<ForgotPasswordController>(
    () => ForgotPasswordController(getIt<SendPasswordResetEmailUseCase>()),
  );
  getIt.registerFactory<SignupController>(
    () => SignupController(getIt<SignUpUseCase>()),
  );

  // Notes
  // Controllers
  getIt.registerFactory<NoteController>(() => NoteController());
}
