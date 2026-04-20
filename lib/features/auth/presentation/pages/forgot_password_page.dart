import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/core/navigation/app_router.dart';
import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/features/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:desafio_target/shared/widgets/app_button.dart';
import 'package:desafio_target/shared/widgets/app_snack_bar.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  late final ForgotPasswordController _controller;
  late final ReactionDisposer _statusDisposer;

  @override
  void initState() {
    super.initState();
    _controller = getIt<ForgotPasswordController>();
    _statusDisposer = reaction(
      (_) => _controller.status,
      (AuthStatusEnum status) {
        if (status == AuthStatusEnum.authenticated) {
          AppSnackBar.show(context, 'Se este e-mail estiver cadastrado, você receberá um link de recuperação.');
          context.canPop() ? context.pop() : context.go(AppRouter.login);
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                  const SizedBox(height: 16),
                  _sendButton(),
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
        const AppText.headline('Recuperar senha'),
        const SizedBox(height: 8),
        AppText.body(
          'Informe seu e-mail e enviaremos um link para redefinir sua senha.',
          color: textSecondary,
          height: 1.5,
        ),
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
              textInputAction: TextInputAction.done,
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

  Widget _sendButton() {
    return Observer(
      builder: (_) => AppButton(
        label: 'Enviar',
        isLoading: _controller.isLoading,
        onPressed: _controller.isFormValid ? _controller.sendPasswordResetEmail : null,
      ),
    );
  }
}
