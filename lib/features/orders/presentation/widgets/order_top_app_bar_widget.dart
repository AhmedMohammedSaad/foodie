import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTopAppBarWidget extends StatelessWidget {
  const OrderTopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Color(0xFF2E2F2F), size: 24.sp),
              ),
              SizedBox(width: 8.w),
              Text(
                'Order #8824',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2F2F),
                  letterSpacing: -0.45,
                ),
              ),
            ],
          ),
          Text(
            'HELP',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF767776),
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
