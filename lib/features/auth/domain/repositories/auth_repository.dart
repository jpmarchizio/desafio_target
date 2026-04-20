import 'package:desafio_target/core/result/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<Result<User>> signIn(String email, String password);
  Future<Result<void>> sendPasswordResetEmail(String email);
  Future<Result<User>> signUp(String email, String password);
}
