import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class OrderStatusTimelineWidget extends StatelessWidget {
  const OrderStatusTimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        children: [
          _buildTimelineStep(
            'Preparing',
            'The kitchen is crafting your meal',
            true,
            true,
          ),
          _buildTimelineStep(
            'On the way',
            'Alex has picked up your order',
            true,
            false,
            isActive: true,
          ),
          _buildTimelineStep(
            'Delivered',
            'Enjoy your meal!',
            false,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    bool showLine,
    bool isCompleted, {
    bool isActive = false,
  }) {
    Color primaryColor = isActive || isCompleted ? AppColors.primary : const Color(0xFFDCDEDC);
    Color textColor = isActive ? AppColors.primary : (isCompleted ? const Color(0xFF767776) : const Color(0xFF5B5C5B));
    Color subtitleColor = isActive ? const Color(0xFF5B5C5B) : (isCompleted ? const Color(0xFFADADAC) : const Color(0xFF5B5C5B));

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indicator & Line
          Column(
            children: [
              Container(
                width: 20.r,
                height: 20.r,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              spreadRadius: 8,
                              blurRadius: 10),
                        ]
                      : null,
                ),
                child: isCompleted
                    ? Icon(Icons.check, color: Colors.white, size: 12.sp)
                    : (isActive
                        ? Center(
                            child: Container(
                                width: 8.r, height: 8.r, color: Colors.white))
                        : null),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: const Color(0xFFE8E8E7),
                  ),
                ),
            ],
          ),
          SizedBox(width: 18.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: subtitleColor,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
