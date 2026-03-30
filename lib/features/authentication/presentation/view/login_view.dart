import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_food/features/authentication/presentation/widgets/login_section.dart';
import 'package:app_food/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:app_food/core/di/injection.dart';
import 'package:app_food/core/router/routes.dart';
import 'package:app_food/core/presentation/view/widgets/app_toast.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
          } else if (state is AuthError) {
            AppToast.showError(context, state.message);
          }
        },
        child: const Scaffold(
          body: SafeArea(
            child: LoginSection(),
          ),
        ),
      ),
    );
  }
}
