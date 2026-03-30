import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel model;
  const OnboardingPageItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          const Spacer(flex: 2),
          Image.asset(model.image, height: 300.h, fit: BoxFit.contain),
          const Spacer(flex: 1),
          Text(
            model.title,
            style: AppTextStyle.font24SemiBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            model.description,
            style: AppTextStyle.font14Regular,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
