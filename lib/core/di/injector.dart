import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:desafio_target/features/notes/data/datasources/note_local_datasource.dart';
import 'package:desafio_target/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:desafio_target/features/notes/data/repositories/note_repository_impl.dart';
import 'package:desafio_target/features/notes/domain/repositories/note_repository.dart';
import 'package:desafio_target/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/edit_note_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/migrate_notes_usecase.dart';
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
    () => SignupController(getIt<SignUpUseCase>(), getIt<MigrateNotesUseCase>()),
  );

  // Notes
  // Services
  getIt.registerLazySingleton<NoteLocalDataSource>(() => NoteLocalDataSource());
  getIt.registerLazySingleton<NoteRemoteDataSource>(() => NoteRemoteDataSource(FirebaseFirestore.instance));
  getIt.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(getIt<NoteLocalDataSource>(), getIt<NoteRemoteDataSource>(), FirebaseAuth.instance),
  );

  // Use Cases
  getIt.registerLazySingleton<GetNotesUseCase>(() => GetNotesUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton<AddNoteUseCase>(() => AddNoteUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton<EditNoteUseCase>(() => EditNoteUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton<DeleteNoteUseCase>(() => DeleteNoteUseCase(getIt<NoteRepository>()));
  getIt.registerLazySingleton<MigrateNotesUseCase>(() => MigrateNotesUseCase(getIt<NoteRepository>()));

  // Controllers
  getIt.registerFactory<NoteController>(
    () => NoteController(
      getIt<GetNotesUseCase>(),
      getIt<AddNoteUseCase>(),
      getIt<EditNoteUseCase>(),
      getIt<DeleteNoteUseCase>(),
    ),
  );
}
