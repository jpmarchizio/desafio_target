import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/core/navigation/app_router.dart';
import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/shared/widgets/app_snack_bar.dart';
import 'package:desafio_target/features/auth/presentation/controllers/signup_controller.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:desafio_target/shared/widgets/app_button.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final SignupController _controller;
  late final ReactionDisposer _statusDisposer;

  @override
  void initState() {
    super.initState();
    _controller = getIt<SignupController>();
    _statusDisposer = reaction(
      (_) => _controller.status,
      (AuthStatusEnum status) {
        if (status == AuthStatusEnum.authenticated) context.go(AppRouter.home);
        if (status == AuthStatusEnum.error) {
          final error = _controller.errorMessage;
          if (error == null) return;

          AppSnackBar.show(context, error);
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRouter.login),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 32),
                  _emailField(),
                  const SizedBox(height: 32),
                  _passwordField(),
                  const SizedBox(height: 12),
                  _confirmPasswordField(),
                  const SizedBox(height: 16),
                  _signupButton(),
                  _errorMessage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.headline('Criar conta'),
        const SizedBox(height: 8),
        AppText.body('Preencha os campos abaixo para criar sua conta.', color: textSecondary, height: 1.5),
      ],
    );
  }

  Widget _emailField() {
    return Observer(
      builder: (_) {
        final emailError = _controller.emailError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'E-mail',
              hint: 'seu@email.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: _controller.onEmailChanged,
            ),
            if (emailError != null) ...[
              const SizedBox(height: 6),
              AppText.bodySmall(emailError, color: AppColors.error),
            ],
          ],
        );
      },
    );
  }

  Widget _passwordField() {
    return Observer(
      builder: (_) {
        final passwordError = _controller.passwordError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Senha',
              hint: '••••••••',
              controller: _passwordController,
              obscureText: _controller.obscurePassword,
              onObscureToggle: _controller.toggleObscurePassword,
              onChanged: _controller.onPasswordChanged,
            ),
            if (passwordError != null) ...[
              const SizedBox(height: 6),
              AppText.bodySmall(passwordError, color: AppColors.error),
            ],
          ],
        );
      },
    );
  }

  Widget _confirmPasswordField() {
    return Observer(
      builder: (_) {
        final confirmPasswordError = _controller.confirmPasswordError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Confirmar senha',
              hint: '••••••••',
              controller: _confirmPasswordController,
              obscureText: _controller.obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              onObscureToggle: _controller.toggleObscureConfirmPassword,
              onChanged: _controller.onConfirmPasswordChanged,
            ),
            if (confirmPasswordError != null) ...[
              const SizedBox(height: 6),
              AppText.bodySmall(confirmPasswordError, color: AppColors.error),
            ],
          ],
        );
      },
    );
  }

  Widget _signupButton() {
    return Observer(
      builder: (_) => AppButton(
        label: 'Criar conta',
        isLoading: _controller.isLoading,
        onPressed: _controller.isFormValid ? _controller.signUp : null,
      ),
    );
  }

  Widget _errorMessage() {
    return Observer(
      builder: (_) {
        final error = _controller.errorMessage;
        final isRemoteError = _controller.status == AuthStatusEnum.error;

        if (error == null || isRemoteError) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AppText.bodySmall(error, color: AppColors.error),
        );
      },
    );
  }
}
