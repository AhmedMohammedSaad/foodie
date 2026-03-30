import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_food/core/theme/app_text_style.dart';
import 'package:app_food/core/presentation/view/widgets/app_default_button.dart';
import 'package:app_food/core/presentation/view/widgets/app_default_text_form_field.dart';
import 'package:app_food/core/presentation/view/widgets/app_toast.dart';
import 'package:app_food/core/router/routes.dart';
import '../cubit/auth_cubit.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AppToast.showSuccess(context, 'Welcome ${state.user.name ?? 'User'}!');
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
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
                SizedBox(height: 60.h),
                Text('Welcome Back!', style: AppTextStyle.font32Bold),
                SizedBox(height: 8.h),
                Text('Login to your account to continue', style: AppTextStyle.font14Regular),
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
                SizedBox(height: 20.h),
                AppDefaultTextFormField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: Text('Forgot Password?', style: AppTextStyle.font14SemiBold),
                  ),
                ),
                SizedBox(height: 32.h),
                AppDefaultButton(
                  text: 'Login',
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                            _emailController.text.trim(),
                            _passwordController.text,
                          );
                    }
                  },
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: AppTextStyle.font14Regular),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.signup);
                      },
                      child: Text('Sign Up', style: AppTextStyle.font14SemiBold),
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
