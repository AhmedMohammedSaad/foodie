import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantDetailsLoadingSection extends StatelessWidget {
  const RestaurantDetailsLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _shimmerBox(height: 300.h, width: double.infinity),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 30.h, width: 200.w),
                SizedBox(height: 10.h),
                _shimmerBox(height: 15.h, width: 150.w),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) => _shimmerBox(height: 40.h, width: 80.w)),
                ),
                SizedBox(height: 30.h),
                _shimmerBox(height: 100.h, width: double.infinity),
                SizedBox(height: 20.h),
                _shimmerBox(height: 100.h, width: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
