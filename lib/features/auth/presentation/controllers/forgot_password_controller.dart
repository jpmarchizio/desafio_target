// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:mobx/mobx.dart';

part 'forgot_password_controller.g.dart';

class ForgotPasswordController = _ForgotPasswordController with _$ForgotPasswordController;

abstract class _ForgotPasswordController with Store {
  final SendPasswordResetEmailUseCase _sendPasswordResetEmail;

  _ForgotPasswordController(this._sendPasswordResetEmail);

  @observable
  AuthStatusEnum status = AuthStatusEnum.initial;

  @computed
  bool get isLoading => status == AuthStatusEnum.loading;

  @observable
  String? errorMessage;

  @action
  void clearError() => errorMessage = null;

  @action
  Future<void> sendPasswordResetEmail(String email) async {
    clearError();
    status = AuthStatusEnum.loading;

    final result = await _sendPasswordResetEmail(email);

    if (result is Failure) {
      errorMessage = result.error.message;
      status = AuthStatusEnum.error;

      return;
    }

    status = AuthStatusEnum.authenticated;
  }
}
