import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/forgot_password_section.dart';
import '../cubit/auth_cubit.dart';
import 'package:app_food/core/di/injection.dart';
import 'package:app_food/core/presentation/view/widgets/app_toast.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordEmailSent) {
            AppToast.showSuccess(context, 'Check your email for password reset link');
          } else if (state is AuthError) {
            AppToast.showError(context, state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: const SafeArea(
            child: ForgotPasswordSection(),
          ),
        ),
      ),
    );
  }
}
