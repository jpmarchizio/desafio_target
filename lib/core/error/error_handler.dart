import 'app_error.dart';

class ErrorHandler {
  ErrorHandler._();

  static AppError handle(Object error) {
    return const AppError(
      message: 'Erro inesperado. Tente novamente.',
      type: AppErrorType.unknown,
    );
  }
}
