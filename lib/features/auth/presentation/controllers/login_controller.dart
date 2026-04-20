// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:desafio_target/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  final SignInUseCase _signIn;
  final SignInAnonymouslyUseCase _signInAnonymously;

  _LoginController(this._signIn, this._signInAnonymously);

  @observable
  AuthStatusEnum status = AuthStatusEnum.initial;

  @computed
  bool get isLoading => status == AuthStatusEnum.loading;

  @observable
  String? errorMessage;

  @observable
  bool obscurePassword = true;

  @action
  void toggleObscurePassword() => obscurePassword = !obscurePassword;

  @action
  void clearError() => errorMessage = null;

  @action
  Future<void> signIn(String email, String password) async {
    clearError();
    status = AuthStatusEnum.loading;

    final result = await _signIn(email, password);
    if (result is Failure) {
      errorMessage = (result as Failure).error.message;
      status = AuthStatusEnum.error;

      return;
    }

    status = AuthStatusEnum.authenticated;
  }

  @action
  Future<void> signInAnonymously() async {
    clearError();
    status = AuthStatusEnum.loading;

    final result = await _signInAnonymously();
    if (result is Failure) {
      errorMessage = (result as Failure).error.message;
      status = AuthStatusEnum.error;

      return;
    }

    status = AuthStatusEnum.authenticated;
  }
}
