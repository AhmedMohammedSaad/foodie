import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../../../core/router/routes.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItemEntity item;
  const MenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: item,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.isBestSeller) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Best Seller',
                        style: AppTextStyle.font12Medium.copyWith(
                          color: AppColors.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                  Text(
                    item.name,
                    style: AppTextStyle.font18SemiBold,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.description,
                    style: AppTextStyle.font12Medium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: AppTextStyle.font18SemiBold.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 112.r,
              height: 112.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: AssetImage(item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
