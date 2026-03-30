import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/restaurant_details_entity.dart';

class RestaurantInfoOverlay extends StatelessWidget {
  final RestaurantDetailsEntity restaurant;

  const RestaurantInfoOverlay({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  restaurant.name,
                  style: AppTextStyle.font24SemiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppColors.primary, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      restaurant.rating.toString(),
                      style: AppTextStyle.font14SemiBold.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            restaurant.description,
            style: AppTextStyle.font14Regular,
          ),
          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(Icons.access_time, restaurant.deliveryTime),
              _infoItem(Icons.location_on_outlined, restaurant.distance),
              _infoItem(Icons.monetization_on_outlined, restaurant.priceRange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppColors.textSecondary),
        SizedBox(width: 6.w),
        Text(text, style: AppTextStyle.font14Regular),
      ],
    );
  }
}
