// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:desafio_target/shared/utils/validators.dart';
import 'package:mobx/mobx.dart';

part 'signup_controller.g.dart';

class SignupController = _SignupController with _$SignupController;

abstract class _SignupController with Store {
  final SignUpUseCase _signUp;

  _SignupController(this._signUp);

  @observable
  AuthStatusEnum status = AuthStatusEnum.initial;

  @computed
  bool get isLoading => status == AuthStatusEnum.loading;

  @observable
  String? errorMessage;

  @observable
  bool obscurePassword = true;

  @observable
  bool obscureConfirmPassword = true;

  @observable
  String email = '';

  @observable
  String? emailError;

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @computed
  bool get isFormValid =>
      isValidEmail(email) &&
      password.length >= 6 &&
      confirmPassword.isNotEmpty &&
      password == confirmPassword;

  @computed
  String? get passwordError =>
      password.isNotEmpty && password.length < 6 ? 'A senha deve ter pelo menos 6 caracteres.' : null;

  @computed
  String? get confirmPasswordError =>
      confirmPassword.isNotEmpty && password != confirmPassword ? 'As senhas não coincidem.' : null;

  @action
  void toggleObscurePassword() => obscurePassword = !obscurePassword;

  @action
  void toggleObscureConfirmPassword() => obscureConfirmPassword = !obscureConfirmPassword;

  @action
  void onEmailChanged(String value) {
    email = value;
    emailError = isValidEmail(value) ? null : 'E-mail inválido.';
    errorMessage = null;
  }

  @action
  void onPasswordChanged(String value) {
    password = value;
    errorMessage = null;
  }

  @action
  void onConfirmPasswordChanged(String value) {
    confirmPassword = value;
    errorMessage = null;
  }

  @action
  void clearError() => errorMessage = null;

  @action
  Future<void> signUp() async {
    clearError();
    status = AuthStatusEnum.loading;

    final result = await _signUp(email, password);

    if (result is Failure) {
      errorMessage = (result as Failure).error.message;
      status = AuthStatusEnum.error;

      return;
    }

    status = AuthStatusEnum.authenticated;
  }
}
