import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/otp_section.dart';
import '../cubit/auth_cubit.dart';
import 'package:app_food/core/di/injection.dart';
import 'package:app_food/core/router/routes.dart';
import 'package:app_food/core/presentation/view/widgets/app_toast.dart';

import 'package:app_food/features/authentication/domain/repositories/auth_repository.dart';

class OtpView extends StatelessWidget {
  final String email;
  final AuthOtpType type;

  const OtpView({
    super.key,
    required this.email,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
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
          body: SafeArea(
            child: OtpSection(email: email, type: type),
          ),
        ),
      ),
    );
  }
}
