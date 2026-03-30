import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/logout_button_section.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_segmented_control.dart';

import '../../../../core/di/injection.dart';
import '../../../home/domain/usecases/get_home_data_usecase.dart';
import '../widgets/profile_favorites_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(sl<GetHomeDataUseCase>()),
      child: const ProfileViewBody(),
    );
  }
}

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileBackground,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.85),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            // Handle back if needed, though mostly inside BottomNav
          },
        ),
        title: Text(
          'Account',
          style: AppTextStyle.font20BoldAccount,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              const ProfileHeaderSection(),
              SizedBox(height: 40.h),
              const ProfileSegmentedControl(),
              SizedBox(height: 32.h),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileSuccess) {
                    if (state.selectedIndex == 0) {
                      return const ProfileMenuSection();
                    } else {
                      return const ProfileFavoritesSection();
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 32.h),
              const LogoutButtonSection(),
              SizedBox(height: 64.h), // Spacing for bottom nav bar
            ],
          ),
        ),
      ),
    );
  }
}
