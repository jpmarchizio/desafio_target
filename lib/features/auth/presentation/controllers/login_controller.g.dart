// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginController, Store {
  late final _$statusAtom = Atom(
    name: '_LoginController.status',
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

  late final _$isSigningInAtom = Atom(
    name: '_LoginController.isSigningIn',
    context: context,
  );

  @override
  bool get isSigningIn {
    _$isSigningInAtom.reportRead();
    return super.isSigningIn;
  }

  @override
  set isSigningIn(bool value) {
    _$isSigningInAtom.reportWrite(value, super.isSigningIn, () {
      super.isSigningIn = value;
    });
  }

  late final _$isSigningInAnonymouslyAtom = Atom(
    name: '_LoginController.isSigningInAnonymously',
    context: context,
  );

  @override
  bool get isSigningInAnonymously {
    _$isSigningInAnonymouslyAtom.reportRead();
    return super.isSigningInAnonymously;
  }

  @override
  set isSigningInAnonymously(bool value) {
    _$isSigningInAnonymouslyAtom.reportWrite(
      value,
      super.isSigningInAnonymously,
      () {
        super.isSigningInAnonymously = value;
      },
    );
  }

  late final _$errorMessageAtom = Atom(
    name: '_LoginController.errorMessage',
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
    name: '_LoginController.obscurePassword',
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

  late final _$signInAsyncAction = AsyncAction(
    '_LoginController.signIn',
    context: context,
  );

  @override
  Future<void> signIn(String email, String password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  late final _$signInAnonymouslyAsyncAction = AsyncAction(
    '_LoginController.signInAnonymously',
    context: context,
  );

  @override
  Future<void> signInAnonymously() {
    return _$signInAnonymouslyAsyncAction.run(() => super.signInAnonymously());
  }

  late final _$_LoginControllerActionController = ActionController(
    name: '_LoginController',
    context: context,
  );

  @override
  void toggleObscurePassword() {
    final _$actionInfo = _$_LoginControllerActionController.startAction(
      name: '_LoginController.toggleObscurePassword',
    );
    try {
      return super.toggleObscurePassword();
    } finally {
      _$_LoginControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_LoginControllerActionController.startAction(
      name: '_LoginController.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_LoginControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
isSigningIn: ${isSigningIn},
isSigningInAnonymously: ${isSigningInAnonymously},
errorMessage: ${errorMessage},
obscurePassword: ${obscurePassword}
    ''';
  }
}
