import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Avatar Wrap
          Positioned(
            top: 0,
            child: SizedBox(
              width: 128.r,
              height: 128.r,
              child: Stack(
                children: [
                  Container(
                    width: 128.r,
                    height: 128.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(color: Colors.white, spreadRadius: 4.r),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 25.r,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/user_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Edit Button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: const BoxDecoration(
                        color: AppColors.profileAvatarEditBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 16.r),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Name
          Positioned(
            top: 144.h,
            child: Text(
              'Julianne Sterling',
              style: AppTextStyle.font24ExtraBoldProfile,
            ),
          ),

          // Email
          Positioned(
            top: 180.h,
            child: Text(
              'j.sterling@design.com',
              style: AppTextStyle.font14MediumProfile,
            ),
          ),
        ],
      ),
    );
  }
}
