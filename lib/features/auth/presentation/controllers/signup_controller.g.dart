// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupController on _SignupController, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_SignupController.isLoading',
  )).value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid => (_$isFormValidComputed ??= Computed<bool>(
    () => super.isFormValid,
    name: '_SignupController.isFormValid',
  )).value;
  Computed<String?>? _$passwordErrorComputed;

  @override
  String? get passwordError => (_$passwordErrorComputed ??= Computed<String?>(
    () => super.passwordError,
    name: '_SignupController.passwordError',
  )).value;
  Computed<String?>? _$confirmPasswordErrorComputed;

  @override
  String? get confirmPasswordError =>
      (_$confirmPasswordErrorComputed ??= Computed<String?>(
        () => super.confirmPasswordError,
        name: '_SignupController.confirmPasswordError',
      )).value;

  late final _$statusAtom = Atom(
    name: '_SignupController.status',
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
    name: '_SignupController.errorMessage',
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

  late final _$obscurePasswordAtom = Atom(
    name: '_SignupController.obscurePassword',
    context: context,
  );

  @override
  bool get obscurePassword {
    _$obscurePasswordAtom.reportRead();
    return super.obscurePassword;
  }

  @override
  set obscurePassword(bool value) {
    _$obscurePasswordAtom.reportWrite(value, super.obscurePassword, () {
      super.obscurePassword = value;
    });
  }

  late final _$obscureConfirmPasswordAtom = Atom(
    name: '_SignupController.obscureConfirmPassword',
    context: context,
  );

  @override
  bool get obscureConfirmPassword {
    _$obscureConfirmPasswordAtom.reportRead();
    return super.obscureConfirmPassword;
  }

  @override
  set obscureConfirmPassword(bool value) {
    _$obscureConfirmPasswordAtom.reportWrite(
      value,
      super.obscureConfirmPassword,
      () {
        super.obscureConfirmPassword = value;
      },
    );
  }

  late final _$emailAtom = Atom(
    name: '_SignupController.email',
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
    name: '_SignupController.emailError',
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

  late final _$passwordAtom = Atom(
    name: '_SignupController.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom = Atom(
    name: '_SignupController.confirmPassword',
    context: context,
  );

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$signUpAsyncAction = AsyncAction(
    '_SignupController.signUp',
    context: context,
  );

  @override
  Future<void> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  late final _$_SignupControllerActionController = ActionController(
    name: '_SignupController',
    context: context,
  );

  @override
  void toggleObscurePassword() {
    final _$actionInfo = _$_SignupControllerActionController.startAction(
      name: '_SignupController.toggleObscurePassword',
    );
    try {
      return super.toggleObscurePassword();
    } finally {
      _$_SignupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleObscureConfirmPassword() {
    final _$actionInfo = _$_SignupControllerActionController.startAction(
      name: '_SignupController.toggleObscureConfirmPassword',
    );
    try {
      return super.toggleObscureConfirmPassword();
    } finally {
      _$_SignupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onEmailChanged(String value) {
    final _$actionInfo = _$_SignupControllerActionController.startAction(
      name: '_SignupController.onEmailChanged',
    );
    try {
      return super.onEmailChanged(value);
    } finally {
      _$_SignupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPasswordChanged(String value) {
    final _$actionInfo = _$_SignupControllerActionController.startAction(
      name: '_SignupController.onPasswordChanged',
    );
    try {
      return super.onPasswordChanged(value);
    } finally {
      _$_SignupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onConfirmPasswordChanged(String value) {
    final _$actionInfo = _$_SignupControllerActionController.startAction(
      name: '_SignupController.onConfirmPasswordChanged',
    );
    try {
      return super.onConfirmPasswordChanged(value);
    } finally {
      _$_SignupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_SignupControllerActionController.startAction(
      name: '_SignupController.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_SignupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
errorMessage: ${errorMessage},
obscurePassword: ${obscurePassword},
obscureConfirmPassword: ${obscureConfirmPassword},
email: ${email},
emailError: ${emailError},
password: ${password},
confirmPassword: ${confirmPassword},
isLoading: ${isLoading},
isFormValid: ${isFormValid},
passwordError: ${passwordError},
confirmPasswordError: ${confirmPasswordError}
    ''';
  }
}
