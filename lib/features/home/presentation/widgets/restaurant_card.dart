import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/router/routes.dart';
import '../../domain/entities/restaurant_entity.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.restaurantDetails,
          arguments: restaurant.id,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 400.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF482603).withOpacity(0.08),
                      blurRadius: 60,
                      offset: const Offset(0, 30),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(restaurant.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 24.h,
                right: 24.w,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFavorite ? const Color(0xFFFF7B04) : Colors.white.withOpacity(0.2),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 24.h,
                left: 24.w,
                child: Row(
                  children: restaurant.tags.map((tag) {
                    final isBestSeller = tag == 'BEST SELLER';
                    return Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isBestSeller ? AppColors.primary : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(9999.r),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: isBestSeller ? Colors.white : const Color(0xFF482603),
                          letterSpacing: 0.6,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF482603),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Icon(Icons.access_time, color: const Color(0xFF7D522B), size: 14.sp),
                        4.horizontalSpace,
                        Expanded(child: Text(
                          '${restaurant.deliveryTime} • ${restaurant.priceRange} • ${restaurant.cuisine}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7D522B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEEE2),
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    4.horizontalSpace,
                    Text(
                      restaurant.rating.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF482603),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
