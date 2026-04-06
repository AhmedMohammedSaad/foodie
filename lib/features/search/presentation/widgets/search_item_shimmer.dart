import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_shimmer.dart';

class SearchItemShimmer extends StatelessWidget {
  const SearchItemShimmer({super.key});

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
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AppShimmerRect(
            width: 64.w,
            height: 64.w,
            radius: 12.r,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppShimmerRect(
                        width: 100.w,
                        height: 16.h,
                        radius: 4.r,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    AppShimmerRect(
                      width: 60.w,
                      height: 20.h,
                      radius: 8.r,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                AppShimmerRect(
                  width: 150.w,
                  height: 14.h,
                  radius: 4.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchListShimmer extends StatelessWidget {
  const SearchListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 24.h),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => const SearchItemShimmer(),
    );
  }
}
