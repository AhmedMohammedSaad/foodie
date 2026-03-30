import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyle {
  static TextStyle font32Bold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static TextStyle font24SemiBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static TextStyle font18SemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static TextStyle font16SemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Poppins',
  );

  static TextStyle font14Regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: 'Poppins',
  );

  static TextStyle font14SemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    fontFamily: 'Poppins',
  );

  static TextStyle font12Medium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: 'Poppins',
  );

  // Profile specific TextStyles
  static TextStyle font24ExtraBoldProfile = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.profileTextPrimary,
    fontFamily: 'Plus Jakarta Sans',
    letterSpacing: -0.6,
  );

  static TextStyle font16BoldProfile = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.profileTextPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );

  static TextStyle font16BoldDanger = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.profileDanger,
    fontFamily: 'Plus Jakarta Sans',
  );

  static TextStyle font14BoldProfile = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.profileTextPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );

  static TextStyle font14SemiBoldProfile = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.profileTextSecondary,
    fontFamily: 'Plus Jakarta Sans',
  );

  static TextStyle font14MediumProfile = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.profileTextSecondary,
    fontFamily: 'Plus Jakarta Sans',
  );

  static TextStyle font20BoldAccount = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF18181B), // Account title color
    fontFamily: 'Plus Jakarta Sans',
    letterSpacing: -0.5,
  );

  static TextStyle font16Medium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static TextStyle font20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );
}
