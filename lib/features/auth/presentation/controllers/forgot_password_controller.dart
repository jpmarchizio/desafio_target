// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:desafio_target/shared/utils/validators.dart';
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
  String email = '';

  @observable
  String? emailError;

  @computed
  bool get isFormValid => isValidEmail(email);

  @action
  void onEmailChanged(String value) {
    email = value;
    emailError = isValidEmail(value) ? null : 'E-mail inválido.';
  }

  @action
  Future<void> sendPasswordResetEmail() async {
    status = AuthStatusEnum.loading;

    final result = await _sendPasswordResetEmail(email);

    if (result is Failure) {
      status = AuthStatusEnum.error;

      return;
    }

    status = AuthStatusEnum.authenticated;
  }
}
