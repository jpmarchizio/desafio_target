import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/core/navigation/app_router.dart';
import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/core/theme/theme_controller.dart';
import 'package:desafio_target/features/auth/presentation/controllers/login_controller.dart';
import 'package:desafio_target/features/auth/presentation/enums/auth_status_enum.dart';
import 'package:desafio_target/shared/widgets/app_button.dart';
import 'package:desafio_target/shared/widgets/app_snack_bar.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final LoginController _loginController;
  late final ReactionDisposer _authDisposer;

  @override
  void initState() {
    super.initState();
    _loginController = getIt<LoginController>();
    _authDisposer = reaction((_) => _loginController.status, (AuthStatusEnum status) {
      if (status == AuthStatusEnum.authenticated) context.go(AppRouter.home);
      if (status == AuthStatusEnum.error) {
        final error = _loginController.errorMessage;
        if (error == null) return;

        AppSnackBar.show(context, error);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = getIt<ThemeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: Icon(themeController.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
              onPressed: themeController.toggleTheme,
            ),
          ),
        ],
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
                  _logo(),
                  const SizedBox(height: 48),
                  _emailField(),
                  const SizedBox(height: 12),
                  _passwordField(),
                  const SizedBox(height: 4),
                  _forgotPassword(),
                  const SizedBox(height: 16),
                  _loginButton(),
                  const SizedBox(height: 16),
                  _divider(),
                  const SizedBox(height: 16),
                  _anonymousButton(),
                  const SizedBox(height: 32),
                  _signUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.primaryDark : AppColors.primary;

    return Center(
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.checklist_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          const AppText.headline('Target To-Do'),
        ],
      ),
    );
  }

  Widget _emailField() {
    return AppTextField(
      label: 'E-mail',
      hint: 'seu@email.com',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) => _loginController.clearError(),
    );
  }

  Widget _passwordField() {
    return Observer(
      builder: (_) => AppTextField(
        label: 'Senha',
        hint: '••••••••',
        controller: _passwordController,
        obscureText: _loginController.obscurePassword,
        textInputAction: TextInputAction.done,
        onObscureToggle: _loginController.toggleObscurePassword,
        onChanged: (_) => _loginController.clearError(),
      ),
    );
  }

  Widget _forgotPassword() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.primaryDark : AppColors.primary;

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.go(AppRouter.forgotPassword),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 4),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: AppText.bodySmall('Esqueci a senha', color: primary),
      ),
    );
  }

  Widget _loginButton() {
    return Observer(
      builder: (_) => AppButton(
        label: 'Entrar',
        isLoading: _loginController.isSigningIn,
        onPressed: () => _loginController.signIn(_emailController.text.trim(), _passwordController.text),
      ),
    );
  }

  Widget _divider() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Row(
      children: [
        Expanded(child: Divider(color: border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppText.label('ou', color: textSecondary),
        ),
        Expanded(child: Divider(color: border)),
      ],
    );
  }

  Widget _anonymousButton() {
    return Observer(
      builder: (_) => AppButton.outlined(
        label: 'Continuar sem conta',
        onPressed: _loginController.isSigningIn ? null : () => context.go(AppRouter.home),
      ),
    );
  }

  Widget _signUp() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final primary = isDark ? AppColors.primaryDark : AppColors.primary;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.bodySmall('Não tem conta? ', color: textSecondary),
          GestureDetector(
            onTap: () => context.go(AppRouter.signup),
            child: AppText.bodySmall('Criar conta', color: primary),
          ),
        ],
      ),
    );
  }
}
