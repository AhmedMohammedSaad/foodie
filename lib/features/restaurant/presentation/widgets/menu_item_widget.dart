import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/food_entity.dart';
import '../../../../core/router/routes.dart';

class MenuItemWidget extends StatelessWidget {
  final FoodEntity item;
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
                  image: NetworkImage(item.imageUrl),
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

