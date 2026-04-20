import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  const SignUpUseCase(this._repository);

  Future<Result<User>> call(String email, String password) => _repository.signUp(email, password);
}
