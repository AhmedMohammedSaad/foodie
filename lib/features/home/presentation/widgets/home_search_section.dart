import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/home_cubit.dart';
import 'filter_bottom_sheet.dart';

class HomeSearchSection extends StatefulWidget {
  const HomeSearchSection({super.key});

  @override
  State<HomeSearchSection> createState() => _HomeSearchSectionState();
}

class _HomeSearchSectionState extends State<HomeSearchSection> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Stack(
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFEEEE2),
              borderRadius: BorderRadius.circular(9999.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF482603).withOpacity(0.04),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.search, color: const Color(0xFF7D522B).withOpacity(0.5), size: 18.sp),
                12.horizontalSpace,
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      context.read<HomeCubit>().updateSearch(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Crave something delicious?',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7D522B).withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF482603),
                    ),
                  ),
                ),
                SizedBox(width: 50.w), // Space for the filter button
              ],
            ),
          ),
          Positioned(
            right: 12.w,
            top: 10.h,
            bottom: 10.h,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: context.read<HomeCubit>(),
                    child: const FilterBottomSheet(),
                  ),
                );
              },
              child: Container(
                width: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7B04),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.tune, color: Colors.white, size: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
