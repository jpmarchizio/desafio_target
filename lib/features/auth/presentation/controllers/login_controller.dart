// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:desafio_target/shared/utils/validators.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  final SignInUseCase _signIn;

  _LoginController(this._signIn);

  @observable
  AuthStatusEnum status = AuthStatusEnum.initial;

  @observable
  bool isSigningIn = false;

  @observable
  String? errorMessage;

  @observable
  bool obscurePassword = true;

  @action
  void toggleObscurePassword() => obscurePassword = !obscurePassword;

  @action
  void clearError() {
    errorMessage = null;
    status = AuthStatusEnum.initial;
  }

  @action
  Future<void> signIn(String email, String password) async {
    clearError();

    if (email.isEmpty || password.isEmpty) {
      errorMessage = 'Preencha e-mail e senha.';
      status = AuthStatusEnum.error;
      return;
    }

    if (!isValidEmail(email)) {
      errorMessage = 'E-mail inválido.';
      status = AuthStatusEnum.error;
      return;
    }

    isSigningIn = true;

    final result = await _signIn(email, password);
    if (result is Failure) {
      isSigningIn = false;
      errorMessage = (result as Failure).error.message;
      status = AuthStatusEnum.error;

      return;
    }

    status = AuthStatusEnum.authenticated;
  }
}
