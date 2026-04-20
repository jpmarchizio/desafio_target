// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  @observable
  bool isLoading = false;

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
    // integração na próxima task
  }

  @action
  Future<void> signInAnonymously() async {
    // integração na próxima task
  }
}
