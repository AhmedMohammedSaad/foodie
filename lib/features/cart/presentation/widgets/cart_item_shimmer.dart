import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AppShimmerRect(width: 80.w, height: 80.h, radius: 12.r),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerRect(width: 120.w, height: 16.h),
                SizedBox(height: 8.h),
                AppShimmerRect(width: 80.w, height: 12.h),
                SizedBox(height: 12.h),
                AppShimmerRect(width: 60.w, height: 16.h),
              ],
            ),
          ),
          Column(
            children: [
              AppShimmerCircle(size: 24.r),
              SizedBox(height: 16.h),
              AppShimmerRect(width: 60.w, height: 24.h, radius: 20.r),
            ],
          ),
        ],
      ),
    );
  }
}
