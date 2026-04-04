import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileSegmentedControl extends StatelessWidget {
  const ProfileSegmentedControl({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is ProfileSuccess) {
          selectedIndex = state.selectedIndex;
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: AppColors.profileGrayBg,
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<ProfileCubit>().changeTab(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(9999.r),
                      boxShadow: selectedIndex == 0
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 12.r,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Profile',
                      style: selectedIndex == 0
                          ? AppTextStyle.font14BoldProfile
                          : AppTextStyle.font14MediumProfile,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<ProfileCubit>().changeTab(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(9999.r),
                      boxShadow: selectedIndex == 1
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 12.r,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Favorites',
                      style: selectedIndex == 1
                          ? AppTextStyle.font14BoldProfile
                          : AppTextStyle.font14MediumProfile,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<ProfileCubit>().changeTab(2),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 2 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(9999.r),
                      boxShadow: selectedIndex == 2
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 12.r,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Orders',
                      style: selectedIndex == 2
                          ? AppTextStyle.font14BoldProfile
                          : AppTextStyle.font14MediumProfile,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
