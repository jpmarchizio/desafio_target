import 'package:desafio_target/core/error/error_handler.dart';
import 'package:desafio_target/core/result/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth;

  const AuthRemoteDataSource(this._auth);

  Future<Result<User>> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      if (user == null) return Failure(ErrorHandler.handle('user is null'));

      return Success(user);
    } catch (e) {
      return Failure(ErrorHandler.handleFirebaseAuth(e));
    }
  }

  Future<Result<User>> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      final user = credential.user;

      if (user == null) return Failure(ErrorHandler.handle('user is null'));

      return Success(user);
    } catch (e) {
      return Failure(ErrorHandler.handleFirebaseAuth(e));
    }
  }

  Future<Result<void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return const Success(null);
    } catch (e) {
      return Failure(ErrorHandler.handleFirebaseAuth(e));
    }
  }
}
