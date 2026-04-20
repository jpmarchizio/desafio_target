import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordResetEmailUseCase {
  final AuthRepository _repository;

  const SendPasswordResetEmailUseCase(this._repository);

  Future<Result<void>> call(String email) => _repository.sendPasswordResetEmail(email);
}
