import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class RiderProfileRowWidget extends StatelessWidget {
  const RiderProfileRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      // margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F0),
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Pic
          Stack(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: Colors.grey[300],
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star,
                    color: AppColors.primary,
                    size: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Alex Rider',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2F2F),
                  ),
                ),
                Text(
                  'Yamaha XMAX • 4.9',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5B5C5B),
                  ),
                ),
              ],
            ),
          ),
          // Action Buttons
          Row(
            children: [
              _buildActionButton(
                Icons.chat_bubble_rounded,
                Colors.white,
                Colors.black,
              ),
              SizedBox(width: 8.w),
              _buildActionButton(Icons.phone, AppColors.primary, Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color bg, Color iconColor) {
    return Container(
      width: 50.r,
      height: 50.r,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: bg.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 20.sp),
    );
  }
}
