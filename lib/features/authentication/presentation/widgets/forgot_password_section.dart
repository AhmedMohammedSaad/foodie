import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_food/core/theme/app_text_style.dart';
import 'package:app_food/core/presentation/view/widgets/app_default_button.dart';
import 'package:app_food/core/presentation/view/widgets/app_default_text_form_field.dart';
import 'package:app_food/core/presentation/view/widgets/app_toast.dart';
import 'package:app_food/core/router/routes.dart';
import 'package:app_food/features/authentication/domain/repositories/auth_repository.dart';
import '../cubit/auth_cubit.dart';

class ForgotPasswordSection extends StatefulWidget {
  const ForgotPasswordSection({super.key});

  @override
  State<ForgotPasswordSection> createState() => _ForgotPasswordSectionState();
}

class _ForgotPasswordSectionState extends State<ForgotPasswordSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordEmailSent) {
          AppToast.showSuccess(context, 'Reset link sent to your email!');
          Navigator.pushNamed(
            context,
            Routes.otp,
            arguments: {
              'email': _emailController.text.trim(),
              'type': AuthOtpType.recovery,
            },
          );
        } else if (state is AuthError) {
          AppToast.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Text('Forgot Password', style: AppTextStyle.font32Bold),
                SizedBox(height: 8.h),
                Text('Enter your email to receive a password reset link', style: AppTextStyle.font14Regular),
                SizedBox(height: 40.h),
                AppDefaultTextFormField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                AppDefaultButton(
                  text: 'Send Reset Link',
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().forgotPassword(_emailController.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
