import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase {
  final AuthRepository _repository;

  const SignInUseCase(this._repository);

  Future<Result<User>> call(String email, String password) => _repository.signIn(email, password);
}
