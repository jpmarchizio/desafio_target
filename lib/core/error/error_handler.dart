import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'app_error.dart';

class ErrorHandler {
  ErrorHandler._();

  static AppError handle(Object error) {
    if (error is TimeoutException) {
      return const AppError(message: 'Tempo de conexão esgotado. Verifique sua internet.', type: AppErrorType.network);
    }

    if (error is SocketException) {
      return const AppError(message: 'Sem conexão. Verifique sua internet.', type: AppErrorType.network);
    }

    if (error is FirebaseException) {
      if (error.code == 'unavailable' || error.code == 'deadline-exceeded') {
        return const AppError(message: 'Serviço indisponível. Tente novamente.', type: AppErrorType.network);
      }
      if (error.code == 'permission-denied') {
        return const AppError(message: 'Permissão negada.', type: AppErrorType.storage);
      }
      return const AppError(message: 'Erro ao acessar os dados. Tente novamente.', type: AppErrorType.storage);
    }

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
