import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            _buildHeaderShimmer(),
            30.verticalSpace,
            _buildSearchShimmer(),
            30.verticalSpace,
            _buildCategoriesShimmer(),
            30.verticalSpace,
            _buildPopularShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerRect(width: 100.w, height: 15.h),
            10.verticalSpace,
            _shimmerRect(width: 150.w, height: 20.h),
          ],
        ),
        _shimmerCircle(size: 45.r),
      ],
    );
  }

  Widget _buildSearchShimmer() {
    return _shimmerRect(width: double.infinity, height: 55.h, radius: 15.r);
  }

  Widget _buildCategoriesShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shimmerRect(width: 120.w, height: 25.h),
            _shimmerRect(width: 50.w, height: 15.h),
          ],
        ),
        20.verticalSpace,
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => 15.horizontalSpace,
            itemBuilder: (_, __) => Column(
              children: [
                _shimmerRect(width: 60.w, height: 60.h, radius: 15.r),
                10.verticalSpace,
                _shimmerRect(width: 40.w, height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shimmerRect(width: 150.w, height: 25.h),
            _shimmerRect(width: 50.w, height: 15.h),
          ],
        ),
        20.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => 20.verticalSpace,
          itemBuilder: (_, __) => Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                _shimmerRect(width: 80.w, height: 80.h, radius: 15.r),
                15.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerRect(width: double.infinity, height: 20.h),
                      10.verticalSpace,
                      _shimmerRect(width: 100.w, height: 15.h),
                      10.verticalSpace,
                      Row(
                        children: [
                          _shimmerRect(width: 40.w, height: 15.h),
                          10.horizontalSpace,
                          _shimmerRect(width: 40.w, height: 15.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _shimmerRect({
    required double width,
    required double height,
    double radius = 4,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
    );
  }

  Widget _shimmerCircle({required double size}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
