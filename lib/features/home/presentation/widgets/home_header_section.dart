import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DELIVER TO',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF7D522B).withOpacity(0.6),
                  letterSpacing: 2,
                ),
              ),
              4.verticalSpace,
              Row(
                children: [
                  Icon(Icons.location_on, color: const Color(0xFFFF7B04), size: 16.sp),
                  4.horizontalSpace,
                  Text(
                    '123 Culinary Way',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF482603),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: const Color(0xFF482603), size: 16.sp),
                ],
              ),
            ],
          ),
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF7B04).withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/images/user_profile.png'), // Need to add this
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
