enum AppErrorType { auth, network, storage, unknown }

class AppError {
  final String message;
  final AppErrorType type;

  const AppError({required this.message, required this.type});
}
