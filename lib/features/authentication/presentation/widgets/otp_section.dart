import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_food/core/theme/app_text_style.dart';
import 'package:app_food/core/presentation/view/widgets/app_default_button.dart';
import 'package:app_food/core/presentation/view/widgets/app_default_text_form_field.dart';
import 'package:app_food/core/presentation/view/widgets/app_toast.dart';
import 'package:app_food/features/authentication/domain/repositories/auth_repository.dart';
import '../cubit/auth_cubit.dart';

class OtpSection extends StatefulWidget {
  final String email;
  final AuthOtpType type;

  const OtpSection({
    super.key,
    required this.email,
    required this.type,
  });

  @override
  State<OtpSection> createState() => _OtpSectionState();
}

class _OtpSectionState extends State<OtpSection> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          AppToast.showSuccess(context, 'OTP Verified Successfully!');
          // Navigate to Reset Password or Home
        } else if (state is AuthError) {
          AppToast.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Text('OTP Verification', style: AppTextStyle.font32Bold),
              SizedBox(height: 8.h),
              Text('Enter the code sent to your email', style: AppTextStyle.font14Regular),
              SizedBox(height: 40.h),
              AppDefaultTextFormField(
                controller: _otpController,
                hintText: 'Enter OTP',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.security_outlined),
              ),
              SizedBox(height: 40.h),
              AppDefaultButton(
                text: 'Verify',
                isLoading: state is AuthLoading,
                onPressed: () {
                  if (_otpController.text.isNotEmpty) {
                    context.read<AuthCubit>().verifyOtp(
                          widget.email,
                          _otpController.text.trim(),
                          widget.type,
                        );
                  }
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text('Resend Code', style: AppTextStyle.font14SemiBold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
