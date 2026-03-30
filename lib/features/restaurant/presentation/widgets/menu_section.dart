import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/restaurant_details_entity.dart';
import 'menu_item_widget.dart';

class MenuSection extends StatelessWidget {
  final RestaurantDetailsEntity restaurant;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const MenuSection({
    super.key,
    required this.restaurant,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = restaurant.menuItems
        .where((item) => item.category == selectedCategory)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sticky-like Category Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: restaurant.categories.map((category) {
              final isSelected = category == selectedCategory;
              return Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: GestureDetector(
                  onTap: () => onCategorySelected(category),
                  child: Column(
                    children: [
                      Text(
                        category,
                        style: AppTextStyle.font18SemiBold.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          width: 4.r,
                          height: 4.r,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 32.h),
        // Menu Items List
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$selectedCategory Items',
                style: AppTextStyle.font24SemiBold,
              ),
              SizedBox(height: 24.h),
              ...filteredItems.map((item) => MenuItemWidget(item: item)).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
