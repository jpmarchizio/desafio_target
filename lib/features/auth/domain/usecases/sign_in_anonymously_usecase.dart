import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInAnonymouslyUseCase {
  final AuthRepository _repository;

  const SignInAnonymouslyUseCase(this._repository);

  Future<Result<User>> call() => _repository.signInAnonymously();
}
