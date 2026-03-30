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

class SignupSection extends StatefulWidget {
  const SignupSection({super.key});

  @override
  State<SignupSection> createState() => _SignupSectionState();
}

class _SignupSectionState extends State<SignupSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AppToast.showSuccess(context, 'Account created successfully! Please verify your email.');
          Navigator.pushNamed(
            context,
            Routes.otp,
            arguments: {
              'email': _emailController.text.trim(),
              'type': AuthOtpType.signup,
            },
          );
        } else if (state is AuthError) {
          AppToast.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text('Create Account', style: AppTextStyle.font32Bold),
                SizedBox(height: 8.h),
                Text('Sign up to start ordering your favorite food', style: AppTextStyle.font14Regular),
                SizedBox(height: 40.h),
                AppDefaultTextFormField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
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
                SizedBox(height: 20.h),
                AppDefaultTextFormField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                AppDefaultButton(
                  text: 'Sign Up',
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signup(
                            _emailController.text.trim(),
                            _passwordController.text,
                            _nameController.text.trim(),
                          );
                    }
                  },
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: AppTextStyle.font14Regular),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Login', style: AppTextStyle.font14SemiBold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
