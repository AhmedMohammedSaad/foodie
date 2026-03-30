import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import 'order_status_timeline.dart';
import 'rider_profile_row.dart';

class OrderTrackingCardSection extends StatelessWidget {
  const OrderTrackingCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.55.sh, // Covers bottom half
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2E2F2F).withOpacity(0.08),
              blurRadius: 60,
              offset: const Offset(0, -20),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Scrollable content (Timeline)
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 40.h,
                  bottom: 120.h,
                  left: 32.w,
                  right: 32.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ESTIMATED ARRIVAL',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Arriving in 15 mins',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2E2F2F),
                        letterSpacing: -0.9,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    const OrderStatusTimelineWidget(),

                    Container(
                      padding: EdgeInsets.only(top: 48.h, bottom: 40.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.9),
                            Colors.white,
                          ],
                          stops: const [0.0, 0.4, 1.0],
                        ),
                      ),
                      child: const RiderProfileRowWidget(),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Bar (Rider Profile)
          ],
        ),
      ),
    );
  }
}
