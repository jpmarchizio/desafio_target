// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordController on _ForgotPasswordController, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_ForgotPasswordController.isLoading',
  )).value;

  late final _$statusAtom = Atom(
    name: '_ForgotPasswordController.status',
    context: context,
  );

  @override
  AuthStatusEnum get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatusEnum value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_ForgotPasswordController.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$sendPasswordResetEmailAsyncAction = AsyncAction(
    '_ForgotPasswordController.sendPasswordResetEmail',
    context: context,
  );

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _$sendPasswordResetEmailAsyncAction.run(
      () => super.sendPasswordResetEmail(email),
    );
  }

  late final _$_ForgotPasswordControllerActionController = ActionController(
    name: '_ForgotPasswordController',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$_ForgotPasswordControllerActionController
        .startAction(name: '_ForgotPasswordController.clearError');
    try {
      return super.clearError();
    } finally {
      _$_ForgotPasswordControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
errorMessage: ${errorMessage},
isLoading: ${isLoading}
    ''';
  }
}
