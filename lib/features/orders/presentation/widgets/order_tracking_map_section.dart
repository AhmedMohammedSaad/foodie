import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTrackingMapSection extends StatelessWidget {
  const OrderTrackingMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.sh, // Takes full height as it's the bottom layer
      color: const Color(0xFFF7F6F5),
      child: Stack(
        children: [
          // Background Placeholder for Map
          Center(
            child: Icon(
              Icons.map_outlined,
              size: 200.sp,
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          
          // User Location Pin
          Positioned(
            left: 100.w,
            top: 150.h,
            child: _buildLocationPin(
              color: const Color(0xFF2E2F2F),
              icon: Icons.person_pin_circle,
            ),
          ),

          // Restaurant Pin
          Positioned(
            right: 120.w,
            bottom: 300.h,
            child: _buildLocationPin(
              color: const Color(0xFF006190),
              icon: Icons.restaurant,
            ),
          ),

          // Delivery Moto Pin (Current Location)
          Positioned(
            left: 200.w,
            top: 250.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLocationPin(
                  color: const Color(0xFFFF7B04),
                  icon: Icons.motorcycle,
                  isLarge: true,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'ALEX',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPin({
    required Color color,
    required IconData icon,
    bool isLarge = false,
  }) {
    double size = isLarge ? 48.r : 40.r;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: (size * 0.4).r,
      ),
    );
  }
}
