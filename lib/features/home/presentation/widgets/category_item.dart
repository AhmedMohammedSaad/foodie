import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/category_entity.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFF7B04) : const Color(0xFFFEEEE2),
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFF7B04).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              category.image, // Using emoji as placeholder
              style: TextStyle(fontSize: 32.sp),
            ),
          ),
          12.verticalSpace,
          Text(
            category.name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFFFF7B04) : const Color(0xFF7D522B),
            ),
          ),
        ],
      ),
    );
  }
}
