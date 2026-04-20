import 'package:firebase_auth/firebase_auth.dart';

import 'app_error.dart';

class ErrorHandler {
  ErrorHandler._();

  static AppError handle(Object error) {
    return const AppError(message: 'Erro inesperado. Tente novamente.', type: AppErrorType.unknown);
  }

  static AppError handleFirebaseAuth(Object error) {
    if (error is FirebaseAuthException) {
      return AppError(message: _firebaseAuthMessage(error.code), type: AppErrorType.auth);
    }

    return handle(error);
  }

  static String _firebaseAuthMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-mail ou senha incorretos.';
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'user-disabled':
        return 'Usuário desativado.';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde.';
      case 'network-request-failed':
        return 'Sem conexão. Verifique sua internet.';
      default:
        return 'Erro inesperado. Tente novamente.';
    }
  }
}
