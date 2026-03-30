import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.receipt_long_outlined,
            title: 'Order History',
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.payments_outlined,
            title: 'Payment Methods',
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.notifications_none_outlined,
            title: 'Notifications',
            hasDot: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool hasDot;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: AppColors.profileGrayBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.profileTextPrimary,
                    size: 20.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: AppTextStyle.font16BoldProfile,
                ),
              ],
            ),
            Row(
              children: [
                if (hasDot) // Notification red dot
                  Container(
                    width: 8.r,
                    height: 8.r,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: const BoxDecoration(
                      color: AppColors.profileDanger,
                      shape: BoxShape.circle,
                    ),
                  ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.profileTextGray,
                  size: 16.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
