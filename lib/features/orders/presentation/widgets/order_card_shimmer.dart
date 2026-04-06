import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppShimmerRect(width: 50.w, height: 50.w, radius: 12.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerRect(width: 150.w, height: 16.h),
                    8.verticalSpace,
                    AppShimmerRect(width: 100.w, height: 12.h),
                  ],
                ),
              ),
              AppShimmerRect(width: 80.w, height: 24.h, radius: 8.r),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppShimmerRect(width: 100.w, height: 14.h),
              AppShimmerRect(width: 80.w, height: 14.h),
            ],
          ),
        ],
      ),
    );
  }
}
