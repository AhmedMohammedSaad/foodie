import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 60.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: const Color(0xFF482603).withOpacity(0.1),
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
          ),
          32.verticalSpace,
          Text(
            'Sort & Filter',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF482603),
            ),
          ),
          24.verticalSpace,
          _buildFilterOption(
            context,
            'Price: Low to High',
            HomeFilterType.priceLowToHigh,
            Icons.trending_up,
          ),
          16.verticalSpace,
          _buildFilterOption(
            context,
            'Price: High to Low',
            HomeFilterType.priceHighToLow,
            Icons.trending_down,
          ),
          16.verticalSpace,
          _buildFilterOption(
            context,
            'Nearest to me',
            HomeFilterType.nearest,
            Icons.location_on_outlined,
          ),
          16.verticalSpace,
          _buildFilterOption(
            context,
            'Farthest from me',
            HomeFilterType.farthest,
            Icons.map_outlined,
          ),
          32.verticalSpace,
          Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
        ],
      ),
    );
  }

  Widget _buildFilterOption(
    BuildContext context,
    String title,
    HomeFilterType type,
    IconData icon,
  ) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isSelected = state is HomeSuccess && state.filterType == type;
        return GestureDetector(
          onTap: () {
            context.read<HomeCubit>().setFilter(type);
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFF7B04) : const Color(0xFFFEEEE2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : const Color(0xFF7D522B),
                  size: 20.sp,
                ),
                16.horizontalSpace,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xFF7D522B),
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20.sp,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
