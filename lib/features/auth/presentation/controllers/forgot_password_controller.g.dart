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
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid => (_$isFormValidComputed ??= Computed<bool>(
    () => super.isFormValid,
    name: '_ForgotPasswordController.isFormValid',
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

  late final _$emailAtom = Atom(
    name: '_ForgotPasswordController.email',
    context: context,
  );

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$emailErrorAtom = Atom(
    name: '_ForgotPasswordController.emailError',
    context: context,
  );

  @override
  String? get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String? value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  late final _$sendPasswordResetEmailAsyncAction = AsyncAction(
    '_ForgotPasswordController.sendPasswordResetEmail',
    context: context,
  );

  @override
  Future<void> sendPasswordResetEmail() {
    return _$sendPasswordResetEmailAsyncAction.run(
      () => super.sendPasswordResetEmail(),
    );
  }

  late final _$_ForgotPasswordControllerActionController = ActionController(
    name: '_ForgotPasswordController',
    context: context,
  );

  @override
  void onEmailChanged(String value) {
    final _$actionInfo = _$_ForgotPasswordControllerActionController
        .startAction(name: '_ForgotPasswordController.onEmailChanged');
    try {
      return super.onEmailChanged(value);
    } finally {
      _$_ForgotPasswordControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
email: ${email},
emailError: ${emailError},
isLoading: ${isLoading},
isFormValid: ${isFormValid}
    ''';
  }
}
