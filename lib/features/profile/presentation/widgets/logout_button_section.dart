import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class LogoutButtonSection extends StatelessWidget {
  const LogoutButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          // Log out logic
        },
        borderRadius: BorderRadius.circular(9999.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: AppColors.profileDanger,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'Log Out',
                style: AppTextStyle.font16BoldDanger,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
