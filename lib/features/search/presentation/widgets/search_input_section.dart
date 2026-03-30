import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/search_cubit.dart';

class SearchInputSection extends StatelessWidget {
  const SearchInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: TextField(
        onChanged: (value) => context.read<SearchCubit>().search(value),
        style: AppTextStyle.font14Regular.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          hintText: 'Crave something delicious?',
          hintStyle: AppTextStyle.font14Regular.copyWith(color: AppColors.textSecondary.withOpacity(0.5)),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 12.w),
            child: Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: 20.r,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 24.h,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.tune,
                color: Colors.white,
                size: 16.r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
