import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class OnboardingNavBar extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingNavBar({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: totalPages,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: const Color(0xFFE0E0E0),
              dotHeight: 8.h,
              dotWidth: 8.w,
              expansionFactor: 4,
              spacing: 8.w,
            ),
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              if (currentPage < totalPages - 1)
                TextButton(
                  onPressed: onSkip,
                  child: Text('Skip', style: AppTextStyle.font14Regular),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  currentPage == totalPages - 1 ? 'Get Started' : 'Next',
                  style: AppTextStyle.font16SemiBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
