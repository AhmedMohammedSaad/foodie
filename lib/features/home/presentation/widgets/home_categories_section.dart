import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'category_item.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Categories',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF482603),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/category');
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF7B04),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  separatorBuilder: (context, index) => 24.horizontalSpace,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return CategoryItem(
                      category: category,
                      isSelected: state.selectedCategoryId == category.id,
                      onTap: () {
                        context.read<HomeCubit>().selectCategory(category.id);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink(); // Skeleton loading handled separately
      },
    );
  }
}
