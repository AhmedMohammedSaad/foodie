import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class RestaurantCardShimmer extends StatelessWidget {
  const RestaurantCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmerRect(
          width: double.infinity,
          height: 400.h,
          radius: 32.r,
        ),
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerRect(width: 200.w, height: 24.h),
                  8.verticalSpace,
                  AppShimmerRect(width: 150.w, height: 16.h),
                ],
              ),
            ),
            AppShimmerRect(width: 60.w, height: 32.h, radius: 20.r),
          ],
        ),
      ],
    );
  }
}
