import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppEmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const AppEmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.search_off,
              size: 80.sp,
              color: const Color(0xFF7D522B).withOpacity(0.2),
            ),
            24.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF482603),
              ),
            ),
            if (subtitle != null) ...[
              12.verticalSpace,
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF7D522B).withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
